package com.dendrito.quando

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.DashPathEffect
import android.graphics.Paint
import android.graphics.RectF
import android.os.SystemClock
import android.widget.RemoteViews
import java.text.DateFormat
import java.util.Date

/**
 * Home-screen widget: the next alarm, a live countdown and today's sun arc
 * with sunrise, sunset and where the sun is now. Tap opens Quando?.
 *
 * It shows what the app last planned (SharedPreferences, keys under
 * `flutter.widget.`), so it works while the app is closed. The app updates
 * it after every re-plan; the phone refreshes it every 30 minutes, which
 * moves the sun and drops an alarm that has passed.
 */
class QuandoWidget : AppWidgetProvider() {
    companion object {
        /** Redraw every Quando? widget now. */
        fun refresh(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(ComponentName(context, QuandoWidget::class.java))
            for (id in ids) manager.updateAppWidget(id, views(context))
        }

        private fun views(context: Context): RemoteViews {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val now = System.currentTimeMillis()
            val v = RemoteViews(context.packageName, R.layout.quando_widget)
            v.setTextViewText(R.id.widget_label, prefs.getString("flutter.widget.label", "") ?: "")

            // Alarms the app planned, soonest first: [[ms, "title"], ...]
            val next = try {
                val a = org.json.JSONArray(prefs.getString("flutter.widget.alarms", "[]"))
                (0 until a.length()).map { a.getJSONArray(it) }.firstOrNull { it.getLong(0) > now }
            } catch (e: Exception) {
                null
            }
            if (next == null) {
                v.setTextViewText(R.id.widget_time, "—")
                v.setTextViewText(R.id.widget_title, prefs.getString("flutter.widget.none", "") ?: "")
                v.setChronometer(R.id.widget_countdown, SystemClock.elapsedRealtime(), "", false)
                v.setViewVisibility(R.id.widget_countdown, android.view.View.GONE)
            } else {
                val at = next.getLong(0)
                v.setTextViewText(R.id.widget_time, DateFormat.getTimeInstance(DateFormat.SHORT).format(Date(at)))
                v.setTextViewText(R.id.widget_title, next.getString(1))
                v.setViewVisibility(R.id.widget_countdown, android.view.View.VISIBLE)
                v.setChronometer(R.id.widget_countdown, SystemClock.elapsedRealtime() + (at - now), null, true)
                v.setChronometerCountDown(R.id.widget_countdown, true)
            }

            val rise = prefs.getLong("flutter.widget.sunrise", 0L)
            val set = prefs.getLong("flutter.widget.sunset", 0L)
            v.setImageViewBitmap(R.id.widget_arc, arc(rise, set, now))

            val open = context.packageManager.getLaunchIntentForPackage(context.packageName)
                ?: Intent(context, MainActivity::class.java)
            v.setOnClickPendingIntent(
                R.id.widget_root,
                PendingIntent.getActivity(context, 0, open, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT),
            )
            return v
        }

        /** The day's arc from sunrise to sunset, the sun on it, times below. */
        private fun arc(rise: Long, set: Long, now: Long): Bitmap {
            val w = 600
            val h = 200
            val bmp = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888)
            val c = Canvas(bmp)
            val box = RectF(40f, 30f, w - 40f, (h - 40f) * 2 - 30f)
            val line = Paint(Paint.ANTI_ALIAS_FLAG).apply {
                style = Paint.Style.STROKE
                strokeWidth = 4f
                color = Color.argb(140, 247, 220, 208)
                pathEffect = DashPathEffect(floatArrayOf(10f, 10f), 0f)
            }
            c.drawArc(box, 180f, 180f, false, line)
            val horizon = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.argb(90, 247, 220, 208); strokeWidth = 2f }
            c.drawLine(20f, h - 40f, w - 20f, h - 40f, horizon)
            if (rise > 0 && set > rise) {
                val t = ((now - rise).toDouble() / (set - rise)).coerceIn(-0.05, 1.05)
                val up = now in rise..set
                val angle = Math.toRadians(180.0 + 180.0 * t.coerceIn(0.0, 1.0))
                val cx = box.centerX() + box.width() / 2 * Math.cos(angle)
                val cy = box.centerY() + box.height() / 2 * Math.sin(angle)
                if (up) {
                    val glow = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.argb(70, 255, 181, 71) }
                    c.drawCircle(cx.toFloat(), cy.toFloat(), 26f, glow)
                }
                val sun = Paint(Paint.ANTI_ALIAS_FLAG).apply {
                    color = if (up) Color.rgb(255, 181, 71) else Color.argb(160, 200, 200, 230)
                }
                c.drawCircle(cx.toFloat(), cy.toFloat(), 14f, sun)
                val text = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.rgb(247, 220, 208); textSize = 26f }
                val fmt = DateFormat.getTimeInstance(DateFormat.SHORT)
                c.drawText("↑ " + fmt.format(Date(rise)), 24f, h - 8f, text)
                val s = "↓ " + fmt.format(Date(set))
                c.drawText(s, w - 24f - text.measureText(s), h - 8f, text)
            }
            return bmp
        }
    }

    override fun onUpdate(context: Context, manager: AppWidgetManager, ids: IntArray) {
        for (id in ids) manager.updateAppWidget(id, views(context))
    }
}
