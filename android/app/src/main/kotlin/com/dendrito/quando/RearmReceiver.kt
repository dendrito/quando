package com.dendrito.quando

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/**
 * Alarms must survive what Android does to them: an app update clears them,
 * a restart needs them set again, and a new time zone moves "07:00".
 * Each of these plans every alarm again in the background.
 */
class RearmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            Intent.ACTION_BOOT_COMPLETED,
            Intent.ACTION_MY_PACKAGE_REPLACED,
            Intent.ACTION_TIMEZONE_CHANGED -> CalendarJob.replanNow(context.applicationContext)
        }
    }
}
