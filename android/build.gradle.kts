// Project-level build.gradle

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Firebase aur Android Gradle Plugin ka connection
        classpath 'com.android.tools.build:gradle:8.1.0'
        classpath 'com.google.gms:google-services:4.4.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.22"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}