package com.dendrito.quando

import android.content.Intent
import android.database.ContentObserver
import android.provider.CalendarContract
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.media.AudioManager
import android.app.NotificationManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.os.Handler
import android.os.Looper
import android.view.KeyEvent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    companion object {
        /** The running app, while it has an engine: background calendar checks go through it. */
        @Volatile
        var live: MainActivity? = null
    }

    private val worker = Executors.newSingleThreadExecutor()
    private val main = Handler(Looper.getMainLooper())
    private val pauseLater = Runnable { mediaKey(KeyEvent.KEYCODE_MEDIA_PAUSE) }
    private var shareChannel: MethodChannel? = null
    private var pendingShared: String? = null
    private var calendarChannel: MethodChannel? = null
    private var calendarObserver: ContentObserver? = null

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        pendingShared = sharedText(intent)
        super.onCreate(savedInstanceState)
    }

    // A link shared to Quando? while it was open.
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val text = sharedText(intent) ?: return
        shareChannel?.invokeMethod("shared", text) ?: run { pendingShared = text }
    }

    private fun sharedText(i: Intent?): String? =
        if (i?.action == Intent.ACTION_SEND && i.type == "text/plain") i.getStringExtra(Intent.EXTRA_TEXT) else null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // App launcher: list the apps you can open, and open one after an alarm.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "quando/apps").setMethodCallHandler { call, result ->
            when (call.method) {
                "list" -> worker.execute {
                    val apps = try { listApps() } catch (e: Exception) { emptyList() }
                    runOnUiThread { result.success(apps) }
                }
                "launch" -> {
                    val pkg = call.argument<String>("package")
                    val intent = pkg?.let { packageManager.getLaunchIntentForPackage(it) }
                    if (intent == null) {
                        result.success(false)
                    } else {
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        try {
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.success(false)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
        phoneChannel(flutterEngine)
        calendarWatch(flutterEngine)
        live = this
        // Share card out, and song links shared in.
        shareChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "quando/share").also {
            it.setMethodCallHandler { call, result ->
                val path = call.argument<String>("path")
                when (call.method) {
                    "story" -> result.success(path != null && Sharing.story(this, path, call.argument("appId")))
                    "send" -> result.success(
                        path != null && Sharing.send(this, path, call.argument("text"), call.argument("package"))
                    )
                    "installed" -> result.success(
                        try {
                            packageManager.getApplicationInfo(call.argument<String>("package") ?: "", 0)
                            true
                        } catch (e: Exception) {
                            false
                        }
                    )
                    // A link shared to Quando? while it was closed.
                    "sharedText" -> {
                        result.success(pendingShared)
                        pendingShared = null
                    }
                    else -> result.notImplemented()
                }
            }
        }
        // Busy mode: Do Not Disturb access, and act on new busy times now.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "quando/busy").setMethodCallHandler { call, result ->
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            when (call.method) {
                "refresh" -> {
                    BusyMode.apply(this)
                    result.success(true)
                }
                // The home-screen widget, after a re-plan.
                "widget" -> {
                    QuandoWidget.refresh(this)
                    result.success(true)
                }
                "policyAllowed" -> result.success(Build.VERSION.SDK_INT >= 23 && nm.isNotificationPolicyAccessGranted)
                "openPolicySettings" -> result.success(
                    try {
                        startActivity(
                            Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
                                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        )
                        true
                    } catch (e: Exception) {
                        false
                    }
                )
                else -> result.notImplemented()
            }
        }
        // Song links: open the song in its app, and play or pause it with the
        // phone's own media signals (like a headphone button).
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "quando/media").setMethodCallHandler { call, result ->
            when (call.method) {
                "open" -> {
                    val url = call.argument<String>("url")
                    try {
                        startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
                        result.success(true)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                }
                "play" -> result.success(mediaKey(KeyEvent.KEYCODE_MEDIA_PLAY))
                "pause" -> {
                    val after = (call.argument<Number>("afterMs") ?: 0).toLong()
                    main.removeCallbacks(pauseLater)
                    if (after <= 0) result.success(mediaKey(KeyEvent.KEYCODE_MEDIA_PAUSE))
                    else result.success(main.postDelayed(pauseLater, after))
                }
                "playing" -> result.success(audio().isMusicActive)
                else -> result.notImplemented()
            }
        }
    }

    // Calendar alarms follow the calendar: tell Dart the moment any calendar
    // on the phone changes (an event added, moved or deleted, or synced in).
    private fun calendarWatch(engine: FlutterEngine) {
        calendarChannel = MethodChannel(engine.dartExecutor.binaryMessenger, "quando/calendar_watch").also {
            it.setMethodCallHandler { call, result ->
                when (call.method) {
                    "start" -> result.success(startCalendarWatch())
                    "stop" -> {
                        stopCalendarWatch()
                        result.success(true)
                    }
                    // Keep following the calendar with Quando? closed.
                    "background" -> result.success(CalendarJob.schedule(applicationContext))
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun startCalendarWatch(): Boolean {
        if (calendarObserver != null) return true
        val observer = object : ContentObserver(main) {
            override fun onChange(selfChange: Boolean) {
                calendarChannel?.invokeMethod("changed", null)
            }
        }
        return try {
            contentResolver.registerContentObserver(CalendarContract.CONTENT_URI, true, observer)
            calendarObserver = observer
            true
        } catch (e: Exception) {
            false
        }
    }

    /** The background job saw a change while Quando? was running. */
    fun calendarChangedInBackground() {
        main.post { calendarChannel?.invokeMethod("refresh", null) }
    }

    private fun stopCalendarWatch() {
        calendarObserver?.let {
            try {
                contentResolver.unregisterContentObserver(it)
            } catch (e: Exception) {
            }
        }
        calendarObserver = null
    }

    override fun onDestroy() {
        stopCalendarWatch()
        if (live === this) live = null
        super.onDestroy()
    }

    // "Ready to ring" checks the plugins don't cover.
    private fun phoneChannel(engine: FlutterEngine) {
        MethodChannel(engine.dartExecutor.binaryMessenger, "quando/phone").setMethodCallHandler { call, result ->
            when (call.method) {
                "brand" -> result.success(Build.MANUFACTURER.lowercase())
                "fullScreen" -> {
                    val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
                    result.success(Build.VERSION.SDK_INT < 34 || nm.canUseFullScreenIntent())
                }
                "openFullScreen" -> {
                    val ok = try {
                        if (Build.VERSION.SDK_INT >= 34) {
                            startActivity(
                                Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT, Uri.parse("package:$packageName"))
                                    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            )
                            true
                        } else false
                    } catch (e: Exception) {
                        false
                    }
                    result.success(ok)
                }
                // Notification access, for loud calendar notifications.
                "listenerAllowed" -> result.success(
                    (Settings.Secure.getString(contentResolver, "enabled_notification_listeners") ?: "")
                        .split(':')
                        .any { it.startsWith("$packageName/") }
                )
                "openListenerSettings" -> result.success(
                    try {
                        startActivity(
                            Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS")
                                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        )
                        true
                    } catch (e: Exception) {
                        false
                    }
                )
                // Which of these apps are on the phone.
                "installed" -> {
                    val pkgs = call.argument<List<String>>("packages") ?: emptyList()
                    result.success(pkgs.filter { pkg ->
                        try {
                            packageManager.getApplicationInfo(pkg, 0)
                            true
                        } catch (e: Exception) {
                            false
                        }
                    })
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun audio() = getSystemService(AUDIO_SERVICE) as AudioManager

    private fun mediaKey(code: Int): Boolean = try {
        audio().dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, code))
        audio().dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_UP, code))
        true
    } catch (e: Exception) {
        false
    }

    private fun listApps(): List<Map<String, Any>> {
        val pm = packageManager
        val launcher = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
        return pm.queryIntentActivities(launcher, 0)
            .map { it.activityInfo }
            .filter { it.packageName != packageName }
            .distinctBy { it.packageName }
            .map { info ->
                mapOf(
                    "package" to info.packageName,
                    "label" to info.loadLabel(pm).toString(),
                    "icon" to png(info.loadIcon(pm)),
                )
            }
            .sortedBy { (it["label"] as String).lowercase() }
    }

    private fun png(d: Drawable): ByteArray {
        val size = 96
        val bmp = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bmp)
        d.setBounds(0, 0, size, size)
        d.draw(canvas)
        val out = ByteArrayOutputStream()
        bmp.compress(Bitmap.CompressFormat.PNG, 100, out)
        bmp.recycle()
        return out.toByteArray()
    }
}
