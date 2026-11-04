plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.dendrito.quando"
    compileSdk = maxOf(flutter.compileSdkVersion, 37)
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.dendrito.alarmapp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // One fixed key for test builds, so each new test APK installs over the
    // last one and Spotify recognises the app. Not the Play Store key: Play
    // signs store releases with its own.
    signingConfigs {
        create("test") {
            storeFile = file("quando-test.jks")
            storePassword = "quandotest"
            keyAlias = "quando-test"
            keyPassword = "quandotest"
        }
        // The Play Store upload key. It lives only in GitHub's secrets, and
        // CI passes it in through these variables when it builds for the store.
        val upload = System.getenv("QUANDO_UPLOAD_KEYSTORE")
        if (!upload.isNullOrEmpty()) {
            create("upload") {
                storeFile = file(upload)
                storePassword = System.getenv("QUANDO_UPLOAD_STORE_PASSWORD")
                keyAlias = System.getenv("QUANDO_UPLOAD_KEY_ALIAS")
                keyPassword = System.getenv("QUANDO_UPLOAD_KEY_PASSWORD")
            }
        }
    }

    // Two apps from one codebase: Quando? for everyone, and the Jewish
    // edition, Matai? On the Sabbath (Shabbat and Yom Tov first), powered by
    // Quando?. Build the second with
    //   flutter build apk --flavor kodesh --dart-define=QUANDO_EDITION=kodesh
    flavorDimensions += "edition"
    productFlavors {
        create("quando") {
            dimension = "edition"
            manifestPlaceholders["appLabel"] = "Quando?"
        }
        create("kodesh") {
            dimension = "edition"
            applicationId = "com.dendrito.quando.kodesh"
            manifestPlaceholders["appLabel"] = "Matai?"
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("test")
        }
        release {
            signingConfig = signingConfigs.findByName("upload") ?: signingConfigs.getByName("test")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
