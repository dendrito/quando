package com.dendrito.quando

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val worker = Executors.newSingleThreadExecutor()

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
