package com.dendrito.quando

import android.app.Notification
import android.app.RemoteInput
import android.content.Context
import android.content.Intent
import android.os.Bundle
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
 * - Busy mode answers: while busy, a message in a picked app gets one
 *   answer per person, through the notification's own Reply action.
 *   Group chats are skipped unless the user allows them.
 *
 * Nothing read here leaves the phone, except the answer the user wrote. Settings come from the Dart side
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
        try {
            autoReply(sbn)
        } catch (e: Exception) {
            Log.e(TAG, "Could not answer a message", e)
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

    private fun autoReply(sbn: StatusBarNotification) {
        val prefs = dart()
        if (!prefs.getBoolean("flutter.busy.replies", false)) return
        if (sbn.packageName !in strings(prefs.getString("flutter.busy.apps", null))) return
        val now = System.currentTimeMillis()
        val busy = BusyMode.active(this, now) ?: return
        // Shabbat and festivals: no answers unless the user chose them.
        if (inQuiet(prefs.getString("flutter.busy.holy", null), now)) return
        val n = sbn.notification ?: return
        if (n.flags and Notification.FLAG_GROUP_SUMMARY != 0) return
        if (sbn.isOngoing) return
        val extras = n.extras ?: return
        val group = extras.getBoolean("android.isGroupConversation", false) ||
            extras.getCharSequence("android.conversationTitle") != null
        if (group && !prefs.getBoolean("flutter.busy.groups", false)) return
        val sender = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString()?.trim().orEmpty()
        if (sender.isEmpty()) return
        val action = replyAction(n) ?: return
        // One answer per person per busy stretch.
        val key = "reply|${busy.id}|${sbn.packageName}|$sender"
        val seen = own()
        if (seen.contains(key)) return
        val text = (prefs.getString("flutter.busy.replyText", null) ?: return)
            .replace("{until}", java.text.DateFormat.getTimeInstance(java.text.DateFormat.SHORT).format(Date(busy.end)))
        val input = action.remoteInputs!!.first { it.allowFreeFormInput }
        val fill = Intent().addFlags(Intent.FLAG_RECEIVER_FOREGROUND)
        RemoteInput.addResultsToIntent(
            arrayOf(input),
            fill,
            Bundle().apply { putCharSequence(input.resultKey, text) },
        )
        action.actionIntent.send(this, 0, fill)
        seen.edit().apply {
            for ((k, v) in seen.all) if (k.startsWith("reply|") && v is Long && now - v > 7 * 24 * 3600 * 1000L) remove(k)
            putLong(key, now)
        }.apply()
    }

    /** The notification's Reply action: one that takes typed text. */
    private fun replyAction(n: Notification): Notification.Action? {
        val actions = n.actions ?: return null
        return actions.firstOrNull { a ->
            a.remoteInputs?.any { it.allowFreeFormInput } == true &&
                (android.os.Build.VERSION.SDK_INT < 28 || a.semanticAction == Notification.Action.SEMANTIC_ACTION_REPLY)
        } ?: actions.firstOrNull { a -> a.remoteInputs?.any { it.allowFreeFormInput } == true }
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
