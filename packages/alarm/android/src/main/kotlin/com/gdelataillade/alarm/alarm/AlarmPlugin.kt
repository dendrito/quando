package com.gdelataillade.alarm.alarm

import com.gdelataillade.alarm.generated.AlarmApi
import com.gdelataillade.alarm.generated.AlarmTriggerApi
import android.app.Activity
import android.app.KeyguardManager
import android.content.Context
import android.os.Build
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import com.gdelataillade.alarm.api.AlarmApiImpl
import com.gdelataillade.alarm.services.AlarmRingingLiveData
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class AlarmPlugin : FlutterPlugin, ActivityAware {
    private var activity: Activity? = null
    private var backupAudioChannel: MethodChannel? = null

    companion object {
        private const val TAG = "AlarmPlugin"

        // Quando: one per Flutter engine (the app, and a short background
        // calendar check). Ring events go to the newest one still attached,
        // so a background engine ending never cuts the app off.
        private val triggerApis = mutableListOf<AlarmTriggerApi>()

        @JvmStatic
        val alarmTriggerApi: AlarmTriggerApi?
            get() = synchronized(triggerApis) { triggerApis.lastOrNull() }
    }

    private var myTriggerApi: AlarmTriggerApi? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        AlarmApi.setUp(binding.binaryMessenger, AlarmApiImpl(binding.applicationContext))
        val api = AlarmTriggerApi(binding.binaryMessenger)
        myTriggerApi = api
        synchronized(triggerApis) { triggerApis.add(api) }
        backupAudioChannel = MethodChannel(binding.binaryMessenger, "quando/alarm_audio").apply {
            setMethodCallHandler { call, result ->
                val id = call.argument<Int>("id")
                val muted = call.argument<Boolean>("muted")
                if (call.method == "mute" && id != null && muted != null) {
                    result.success(AlarmService.instance?.muteBackup(id, muted) ?: false)
                } else result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        AlarmApi.setUp(binding.binaryMessenger, null)
        myTriggerApi?.let { api -> synchronized(triggerApis) { triggerApis.remove(api) } }
        myTriggerApi = null
        backupAudioChannel?.setMethodCallHandler(null)
        backupAudioChannel = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        AlarmRingingLiveData.instance.observe(
            binding.activity as LifecycleOwner,
            notificationObserver
        )
    }

    override fun onDetachedFromActivity() {
        activity = null
        AlarmRingingLiveData.instance.removeObserver(notificationObserver)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    private val notificationObserver = Observer<Boolean> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O_MR1) {
            Log.w(TAG, "Making app visible on lock screen is not supported on this version of Android.")
            return@Observer
        }
        val activity = activity ?: return@Observer
        if (it) {
            Log.d(TAG, "Making app visible on lock screen...")
            activity.setShowWhenLocked(true)
            activity.setTurnScreenOn(true)
            // The calls above already show the alarm over the lock screen; dismissing a
            // secure keyguard on top of that would only prompt the user to authenticate.
            val keyguardManager =
                activity.applicationContext.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
            if (!keyguardManager.isDeviceSecure) {
                keyguardManager.requestDismissKeyguard(activity, null)
            }
        } else {
            Log.d(TAG, "Reverting making app visible on lock screen...")
            activity.setShowWhenLocked(false)
            activity.setTurnScreenOn(false)
        }
    }
}
