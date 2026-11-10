package com.dendrito.quando

import android.app.Notification
import android.content.Context
import android.content.SharedPreferences
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import com.gdelataillade.alarm.services.ExternalAlarm
import org.json.JSONArray
import java.util.Date

/**
 * Reads notifications only for the features the user turned on, and only
 * from the apps they picked:
 *
 * - "Make calendar notifications loud": a reminder from a calendar app rings
 *   as a Quando? alarm, unless Quando? already rings for that event.
 *
 * Nothing read here leaves the phone. Settings come from the Dart side
 * through SharedPreferences (keys under `flutter.`).
 */
class QuandoListener : NotificationListenerService() {
    companion object {
        private const val TAG = "QuandoListener"
        private const val DART_PREFS = "FlutterSharedPreferences"
        private const val OWN_PREFS = "quando.listener"

        const val LOUD_ON = "flutter.loudCalendar.on"
        const val LOUD_APPS = "flutter.loudCalendar.apps"
        const val LOUD_TEMPLATE = "flutter.loudCalendar.template"
        const val LOUD_PLANNED = "flutter.loudCalendar.planned"
        const val LOUD_QUIET = "flutter.loudCalendar.quiet"

        /** Same reminder posted again (updated, re-shown): ring once. */
        private const val SEEN_FOR_MS = 30 * 60 * 1000L

        /** Quando? already rings within this of the notification: skip it. */
        private const val PLANNED_NEAR_MS = 10 * 60 * 1000L

        /** Ring a moment later, so the alarm is armed through AlarmManager. */
        private const val RING_DELAY_MS = 6_000L

        /** Alarm ids for rung notifications, apart from Dart's planned ids. */
        private const val ID_BASE = 1_900_000_000
    }

    private fun dart(): SharedPreferences = getSharedPreferences(DART_PREFS, Context.MODE_PRIVATE)
    private fun own(): SharedPreferences = getSharedPreferences(OWN_PREFS, Context.MODE_PRIVATE)

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        if (sbn == null) return
        try {
            loudCalendar(sbn)
        } catch (e: Exception) {
            Log.e(TAG, "Could not handle a notification", e)
        }
    }

    private fun loudCalendar(sbn: StatusBarNotification) {
        val prefs = dart()
        if (!prefs.getBoolean(LOUD_ON, false)) return
        val apps = strings(prefs.getString(LOUD_APPS, null))
        if (sbn.packageName !in apps) return
        val n = sbn.notification ?: return
        if (n.flags and Notification.FLAG_GROUP_SUMMARY != 0) return
        if (sbn.isOngoing) return
        val title = n.extras?.getCharSequence(Notification.EXTRA_TITLE)?.toString()?.trim().orEmpty()
        if (title.isEmpty()) return
        val body = n.extras?.getCharSequence(Notification.EXTRA_TEXT)?.toString()?.trim().orEmpty()
        val now = System.currentTimeMillis()

        // Quiet during Shabbat and festivals, when Shabbat is in use.
        if (inQuiet(prefs.getString(LOUD_QUIET, null), now)) return
        // Quando? rings this event itself (a calendar alarm): don't ring twice.
        if (planned(prefs.getString(LOUD_PLANNED, null), title, now)) return
        // The same reminder again: ring once.
        val key = "${sbn.packageName}|$title|$body"
        val seen = own()
        val last = seen.getLong(key, 0L)
        if (now - last < SEEN_FOR_MS) return
        val template = prefs.getString(LOUD_TEMPLATE, null) ?: return
        val id = ID_BASE + Math.floorMod(key.hashCode(), 100_000_000)
        if (ExternalAlarm.ring(this, template, id, Date(now + RING_DELAY_MS), title, body)) {
            seen.edit().apply {
                // Forget old ones so this never grows.
                for ((k, v) in seen.all) if (v is Long && now - v > SEEN_FOR_MS) remove(k)
                putLong(key, now)
            }.apply()
        }
    }

    private fun strings(raw: String?): Set<String> {
        if (raw.isNullOrEmpty()) return emptySet()
        val a = JSONArray(raw)
        return (0 until a.length()).map { a.getString(it) }.toSet()
    }

    /** `[[startMs, endMs], ...]` */
    private fun inQuiet(raw: String?, now: Long): Boolean {
        if (raw.isNullOrEmpty()) return false
        val a = JSONArray(raw)
        for (i in 0 until a.length()) {
            val p = a.getJSONArray(i)
            if (now >= p.getLong(0) && now < p.getLong(1)) return true
        }
        return false
    }

    /** `[{"t": "dentist", "at": ms}, ...]`: Quando? alarms for calendar events. */
    private fun planned(raw: String?, title: String, now: Long): Boolean {
        if (raw.isNullOrEmpty()) return false
        val want = title.lowercase()
        val a = JSONArray(raw)
        for (i in 0 until a.length()) {
            val o = a.getJSONObject(i)
            if (Math.abs(o.getLong("at") - now) > PLANNED_NEAR_MS) continue
            val t = o.getString("t").lowercase()
            if (t.isNotEmpty() && (want.contains(t) || t.contains(want))) return true
        }
        return false
    }
}
