This document describes changes made to upgrade the Android module to target Java 21.

What changed

- `android/app/build.gradle.kts`
  - Updated `sourceCompatibility` and `targetCompatibility` to Java 21
  - Updated Kotlin `jvmTarget` to Java 21
  - Added Gradle Java toolchain configuration requesting languageVersion 21

Notes and verification

1. Gradle wrapper in `android/gradle/wrapper/gradle-wrapper.properties` is currently set to `gradle-8.10.2-all.zip` which is compatible with Java 21 and AGP 8.7.0.
2. Android Gradle Plugin (AGP) is declared in `android/settings.gradle.kts` as `8.7.0`. AGP 8.7.x is compatible with Gradle 8.10.2.
3. You must install a JDK 21 on the development machine or configure Gradle to download/point to a JDK 21 distribution. On CI, set JAVA_HOME to a JDK 21 installation.

Quick local test (Windows PowerShell):

# Ensure JAVA_HOME points to a JDK 21 installation
$env:JAVA_HOME = 'C:\path\to\jdk-21'
# Run a Gradle build for the Android module
cd android; .\gradlew.bat assembleDebug

If the build fails due to missing JDK, install a JDK 21 distribution such as Temurin (Eclipse Adoptium) or Microsoft Build of OpenJDK and point JAVA_HOME to it.

Follow-ups

- Consider upgrading AGP and Kotlin plugin versions if you plan to use newer Android features; test carefully.
- If CI uses a hosted runner, update the runner image or install JDK 21 before the build.
