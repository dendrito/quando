package com.dendrito.quando

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Build
import android.util.Log
import org.json.JSONArray

/** One busy stretch, from the Dart side. */
data class BusyWindow(val start: Long, val end: Long, val id: String)

/**
 * Busy mode without Flutter: Do Not Disturb on at the start of each busy
 * stretch and back off at its end, and the stretch the auto-replies use.
 *
 * Do Not Disturb is set to Priority only, so alarms (Quando?'s included)
 * still ring. It is only turned back off if Quando? turned it on and it is
 * still as Quando? left it.
 */
object BusyMode {
    private const val TAG = "QuandoBusy"
    private const val DART_PREFS = "FlutterSharedPreferences"
    private const val OWN_PREFS = "quando.busy"
    const val ACTION_TICK = "com.dendrito.quando.BUSY_TICK"

    fun dart(context: Context): SharedPreferences =
        context.getSharedPreferences(DART_PREFS, Context.MODE_PRIVATE)

    fun windows(context: Context): List<BusyWindow> {
        val raw = dart(context).getString("flutter.busy.windows", null) ?: return emptyList()
        return try {
            val a = JSONArray(raw)
            (0 until a.length()).map {
                val w = a.getJSONArray(it)
                BusyWindow(w.getLong(0), w.getLong(1), w.getString(2))
            }
        } catch (e: Exception) {
            emptyList()
        }
    }

    fun active(context: Context, now: Long = System.currentTimeMillis()): BusyWindow? =
        windows(context).filter { now >= it.start && now < it.end }.maxByOrNull { it.end }

    /** Puts Do Not Disturb where it should be now, and wakes up at the next change. */
    fun apply(context: Context) {
        try {
            val now = System.currentTimeMillis()
            val busy = active(context, now)
            val nm = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            val own = context.getSharedPreferences(OWN_PREFS, Context.MODE_PRIVATE)
            val wantDnd = dart(context).getBoolean("flutter.busy.dnd", true)
            val allowed = Build.VERSION.SDK_INT >= 23 && nm.isNotificationPolicyAccessGranted
            val ours = own.getBoolean("dndOurs", false)
            if (allowed) {
                if (busy != null && wantDnd && !ours) {
                    val before = nm.currentInterruptionFilter
                    if (before == NotificationManager.INTERRUPTION_FILTER_ALL) {
                        nm.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY)
                        own.edit().putBoolean("dndOurs", true).apply()
                    }
                } else if ((busy == null || !wantDnd) && ours) {
                    if (nm.currentInterruptionFilter == NotificationManager.INTERRUPTION_FILTER_PRIORITY) {
                        nm.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL)
                    }
                    own.edit().putBoolean("dndOurs", false).apply()
                }
            }
            scheduleNext(context, now)
        } catch (e: Exception) {
            Log.e(TAG, "Busy mode could not update", e)
        }
    }

    private fun scheduleNext(context: Context, now: Long) {
        val next = windows(context)
            .flatMap { listOf(it.start, it.end) }
            .filter { it > now }
            .minOrNull()
        val am = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val pi = PendingIntent.getBroadcast(
            context,
            7301,
            Intent(context, BusyReceiver::class.java).setAction(ACTION_TICK),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        am.cancel(pi)
        if (next == null) return
        try {
            if (Build.VERSION.SDK_INT >= 31 && !am.canScheduleExactAlarms()) {
                am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next, pi)
            } else {
                am.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next, pi)
            }
        } catch (e: SecurityException) {
            am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next, pi)
        }
    }
}

/** Busy mode's own timer, and after a restart or an update. */
class BusyReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        BusyMode.apply(context)
    }
}
