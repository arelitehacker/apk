
plugins {
    id "com.android.application"
    id "kotlin-android"
    // Firebase plugin lazmi hai google-services.json ke liye
    id "com.google.gms.google-services"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace "com.earnmoney.yt.earn_money_yt"
    compileSdk flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }

    defaultConfig {
        // Yaad rakho: Ye wahi ID honi chahiye jo Firebase Console mein dali thi
        applicationId "com.earnmoney.yt.earn_money_yt"
        
        // Spying features ke liye minSdk kam se kam 21 hona chahiye
        minSdk 21 
        targetSdk flutter.targetSdk
        versionCode flutter.versionCode
        versionName flutter.versionName
    }

    buildTypes {
        release {
            // Signing configuration for release
            signingConfig signingConfigs.debug
            minifyEnabled false
            shrinkResources false
        }
    }
}

flutter {
    source "../.."
}

dependencies {
    // Firebase Bill of Materials
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-analytics'
    implementation 'com.google.firebase:firebase-messaging'
}