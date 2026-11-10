package com.dendrito.quando

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import java.io.File

/** Its own class, so it never clashes with a plugin's FileProvider. */
class ShareFileProvider : FileProvider()

/**
 * The share card and your own photos or videos, handed to another app.
 * Quando? only opens the other app with the picture loaded; you always
 * post it yourself.
 */
object Sharing {
    private fun uri(activity: Activity, path: String): Uri {
        val src = File(path)
        // Only files in Quando?'s share folder are shared.
        val dir = File(activity.cacheDir, "share").apply { mkdirs() }
        val file = if (src.parentFile?.canonicalPath == dir.canonicalPath) src else {
            File(dir, src.name).also { src.copyTo(it, overwrite = true) }
        }
        return FileProvider.getUriForFile(activity, "${activity.packageName}.share", file)
    }

    private fun mime(path: String) = if (path.lowercase().endsWith(".mp4")) "video/mp4" else "image/png"

    /** Instagram Stories, with the picture as the background. */
    fun story(activity: Activity, path: String, appId: String?): Boolean {
        val u = uri(activity, path)
        val intent = Intent("com.instagram.share.ADD_TO_STORY")
            .setDataAndType(u, mime(path))
            .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            .setPackage("com.instagram.android")
        if (!appId.isNullOrEmpty()) intent.putExtra("source_application", appId)
        activity.grantUriPermission("com.instagram.android", u, Intent.FLAG_GRANT_READ_URI_PERMISSION)
        return start(activity, intent)
    }

    /** WhatsApp or WhatsApp Business: pick a chat or "My status" there. */
    fun send(activity: Activity, path: String, text: String?, pkg: String?): Boolean {
        val u = uri(activity, path)
        val intent = Intent(Intent.ACTION_SEND)
            .setType(mime(path))
            .putExtra(Intent.EXTRA_STREAM, u)
            .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        if (!text.isNullOrEmpty()) intent.putExtra(Intent.EXTRA_TEXT, text)
        if (pkg != null) {
            intent.setPackage(pkg)
            return start(activity, intent)
        }
        return start(activity, Intent.createChooser(intent, null))
    }

    private fun start(activity: Activity, intent: Intent): Boolean = try {
        activity.startActivity(intent)
        true
    } catch (e: ActivityNotFoundException) {
        false
    }
}
