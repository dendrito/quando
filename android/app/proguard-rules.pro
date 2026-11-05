# Release builds shrink and rename code. Spotify's App Remote kit turns its
# messages to and from the Spotify app into objects by field name, so its
# classes must keep their names or direct play fails only in release builds.
-keep class com.spotify.** { *; }
-keep interface com.spotify.** { *; }
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod
-dontwarn com.spotify.**
