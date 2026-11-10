package com.dendrito.quando

import android.content.Intent
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
    private val worker = Executors.newSingleThreadExecutor()
    private val main = Handler(Looper.getMainLooper())
    private val pauseLater = Runnable { mediaKey(KeyEvent.KEYCODE_MEDIA_PAUSE) }

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
        // Busy mode: Do Not Disturb access, and act on new busy times now.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "quando/busy").setMethodCallHandler { call, result ->
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            when (call.method) {
                "refresh" -> {
                    BusyMode.apply(this)
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
