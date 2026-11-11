package com.dendrito.quando

import android.app.job.JobInfo
import android.app.job.JobParameters
import android.app.job.JobScheduler
import android.app.job.JobService
import android.content.ComponentName
import android.content.Context
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.CalendarContract
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

/**
 * Calendar alarms follow the calendar with Quando? closed.
 *
 * Android wakes this job a few seconds after any calendar on the phone
 * changes (a content trigger on the calendar store), and every 15 minutes
 * as a backup and for Google Calendar read online. It runs Dart's
 * `calendarBackground()` in a short-lived engine, which reads the calendar
 * again and moves, adds or removes alarms, then says "done".
 *
 * When Quando? is already running (in front or in the back), its own engine
 * is asked to read again instead, so two engines never set alarms at once.
 */
class CalendarJob : JobService() {
    companion object {
        private const val CHANGE_JOB = 41001
        private const val BACKUP_JOB = 41002
        private const val TIMEOUT_MS = 60_000L

        /** Starts (or renews) both jobs. Safe to call often. */
        fun schedule(context: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) return false
            val js = context.getSystemService(JobScheduler::class.java) ?: return false
            val component = ComponentName(context, CalendarJob::class.java)
            return try {
                // A content trigger fires once, so it is set again every run.
                js.schedule(
                    JobInfo.Builder(CHANGE_JOB, component)
                        .addTriggerContentUri(
                            JobInfo.TriggerContentUri(
                                CalendarContract.CONTENT_URI,
                                JobInfo.TriggerContentUri.FLAG_NOTIFY_FOR_DESCENDANTS
                            )
                        )
                        // A burst of edits (or a sync) counts once.
                        .setTriggerContentUpdateDelay(2_000)
                        .setTriggerContentMaxDelay(15_000)
                        .build()
                )
                if (js.getPendingJob(BACKUP_JOB) == null) {
                    js.schedule(
                        JobInfo.Builder(BACKUP_JOB, component)
                            .setPeriodic(15 * 60 * 1000L)
                            .setPersisted(true)
                            .build()
                    )
                }
                true
            } catch (e: Exception) {
                false
            }
        }
    }

    private val main = Handler(Looper.getMainLooper())
    private var engine: FlutterEngine? = null
    private var running: JobParameters? = null
    private val timeout = Runnable { finish(false) }

    override fun onStartJob(params: JobParameters): Boolean {
        // Renew the one-shot trigger first, so no change is missed.
        schedule(applicationContext)
        // Quando? is running: its own engine reads again.
        MainActivity.live?.let {
            it.calendarChangedInBackground()
            return false
        }
        if (engine != null) return false
        running = params
        return try {
            val loader = FlutterInjector.instance().flutterLoader()
            loader.startInitialization(applicationContext)
            loader.ensureInitializationCompleteAsync(applicationContext, null, main) {
                if (running == null) return@ensureInitializationCompleteAsync
                val e = FlutterEngine(applicationContext)
                engine = e
                MethodChannel(e.dartExecutor.binaryMessenger, "quando/calendar_job").setMethodCallHandler { call, result ->
                    if (call.method == "done") {
                        result.success(null)
                        main.post { finish(false) }
                    } else {
                        result.notImplemented()
                    }
                }
                e.dartExecutor.executeDartEntrypoint(
                    DartExecutor.DartEntrypoint(loader.findAppBundlePath(), "calendarBackground")
                )
            }
            main.postDelayed(timeout, TIMEOUT_MS)
            true
        } catch (e: Exception) {
            running = null
            false
        }
    }

    override fun onStopJob(params: JobParameters): Boolean {
        cleanUp()
        return false
    }

    private fun finish(retry: Boolean) {
        val params = running ?: return
        cleanUp()
        jobFinished(params, retry)
    }

    private fun cleanUp() {
        main.removeCallbacks(timeout)
        running = null
        engine?.destroy()
        engine = null
    }
}
