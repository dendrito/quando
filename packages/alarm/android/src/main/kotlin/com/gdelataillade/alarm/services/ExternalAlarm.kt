package com.gdelataillade.alarm.services

import android.content.Context
import com.gdelataillade.alarm.models.AlarmSettings
import com.gdelataillade.alarm.models.NotificationSettings
import com.gdelataillade.alarm.models.VolumeFadeStep
import com.gdelataillade.alarm.models.VolumeSettings
import io.flutter.Log
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import kotlin.time.Duration.Companion.microseconds

/**
 * Sets an alarm from native code while no Dart isolate may be running, for
 * Quando? (it turns calendar notifications into ringing alarms).
 *
 * The caller hands a template: the JSON Dart's `AlarmSettings.toJson()`
 * writes. Only id, time, title and body change. The alarm is stored in both
 * places Dart and Kotlin read, so the ringing screen finds its settings when
 * the phone opens the app for it.
 */
object ExternalAlarm {
    private const val TAG = "ExternalAlarm"
    private const val DART_PREFS = "FlutterSharedPreferences"
    private const val DART_PREFIX = "flutter.__alarm_id__"

    fun ring(
        context: Context,
        templateJson: String,
        id: Int,
        at: Date,
        title: String,
        body: String,
    ): Boolean = try {
        val dart = JSONObject(templateJson)
        dart.put("id", id)
        // Dart writes local time without a zone, as DateTime.toIso8601String().
        dart.put("dateTime", SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS", Locale.US).format(at))
        val note = dart.getJSONObject("notificationSettings")
        note.put("title", title)
        note.put("body", body)
        dart.optString("payload", "").takeIf { it.isNotEmpty() }?.let {
            val payload = JSONObject(it)
            payload.put("title", title)
            payload.put("body", body)
            dart.put("payload", payload.toString())
        }

        context.getSharedPreferences(DART_PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString("$DART_PREFIX$id", dart.toString())
            .commit()

        val settings = toNative(dart, id, at)
        val ok = AlarmScheduler.schedule(context, settings)
        if (!ok) {
            context.getSharedPreferences(DART_PREFS, Context.MODE_PRIVATE)
                .edit().remove("$DART_PREFIX$id").commit()
        }
        ok
    } catch (e: Exception) {
        Log.e(TAG, "Could not set alarm $id from a template", e)
        false
    }

    private fun toNative(dart: JSONObject, id: Int, at: Date): AlarmSettings {
        val vol = dart.optJSONObject("volumeSettings") ?: JSONObject()
        val steps = vol.optJSONArray("fadeSteps")
        val fadeSteps = buildList {
            if (steps != null) {
                for (i in 0 until steps.length()) {
                    val s = steps.getJSONObject(i)
                    add(VolumeFadeStep(s.getLong("time").microseconds, s.getDouble("volume")))
                }
            }
        }
        val note = dart.getJSONObject("notificationSettings")
        return AlarmSettings(
            id = id,
            dateTime = at,
            assetAudioPath = dart.optStringOrNull("assetAudioPath"),
            volumeSettings = VolumeSettings(
                volume = if (vol.has("volume") && !vol.isNull("volume")) vol.getDouble("volume") else null,
                fadeDuration = if (vol.has("fadeDuration") && !vol.isNull("fadeDuration")) {
                    vol.getLong("fadeDuration").microseconds
                } else null,
                fadeSteps = fadeSteps,
                volumeEnforced = vol.optBoolean("volumeEnforced", false),
                showSystemUI = vol.optBoolean("showSystemUI", true),
            ),
            notificationSettings = NotificationSettings(
                title = note.getString("title"),
                body = note.getString("body"),
                stopButton = note.optStringOrNull("stopButton"),
                icon = note.optStringOrNull("icon"),
                keepNotificationAfterAlarmEnds = note.optBoolean("keepNotificationAfterAlarmEnds", false),
                androidSnoozeButton = note.optStringOrNull("androidSnoozeButton"),
                androidStopAlarmOnDismiss = note.optBoolean("androidStopAlarmOnDismiss", true),
            ),
            loopAudio = dart.optBoolean("loopAudio", true),
            vibrate = dart.optBoolean("vibrate", true),
            warningNotificationOnKill = dart.optBoolean("warningNotificationOnKill", true),
            androidFullScreenIntent = dart.optBoolean("androidFullScreenIntent", true),
            allowAlarmOverlap = dart.optBoolean("allowAlarmOverlap", false),
            allowSameSecondScheduling = dart.optBoolean("allowSameSecondScheduling", false),
            androidStopAlarmOnTermination = dart.optBoolean("androidStopAlarmOnTermination", true),
            preferConnectedAudioDevice = dart.optBoolean("preferConnectedAudioDevice", false),
            androidAlarmClock = dart.optBoolean("androidAlarmClock", true),
        )
    }

    private fun JSONObject.optStringOrNull(key: String): String? =
        if (has(key) && !isNull(key)) getString(key) else null
}
