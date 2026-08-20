plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // or kotlin-android if older version
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins
    id("dev.flutter.flutter-gradle-plugin")

    // Add the Google services plugin (for Firebase)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.untitled"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Use your own Application ID (important for Firebase config!)
        applicationId = "com.example.untitled"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Replace with your signing config for release builds
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Import the Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.2.0"))

    // Add the Firebase SDKs you need (versions come from BoM, so don’t specify manually)
    implementation("com.google.firebase:firebase-analytics")
    // Example extra dependencies (uncomment if needed):
    // implementation("com.google.firebase:firebase-auth")
    // implementation("com.google.firebase:firebase-firestore")
    // implementation("com.google.firebase:firebase-messaging")
}















