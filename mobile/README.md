# Little Ask Mobile

The Flutter application lives in this directory. The NestJS backend remains in
the repository's separate `backend/` directory.

## Windows Android setup (command-line tools)

Install [Flutter 3.50.0](https://docs.flutter.dev/get-started/install/windows/mobile),
a standalone [JDK 21](https://adoptium.net/temurin/releases/?version=21), and
the [Android SDK Command-line Tools](https://developer.android.com/studio#command-line-tools-only)
for Windows. Android Studio IDE is not required. Extract the command-line tools
so their `bin` directory is `%LOCALAPPDATA%\Android\sdk\cmdline-tools\latest\bin`.
In PowerShell, configure the SDK path and ensure the SDK tools are on `PATH`:

```powershell
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\sdk"
$env:ANDROID_SDK_ROOT = $env:ANDROID_HOME
$env:Path += ";$env:ANDROID_HOME\cmdline-tools\latest\bin;$env:ANDROID_HOME\platform-tools"
```

Set `JAVA_HOME` to the installed JDK 21 directory and add its `bin` directory to
`PATH`. Flutter 3.50 uses Android API 36 and NDK 28.2.13676358 by default;
install those build tools, accept the SDK licenses, and confirm Flutter sees
the toolchain:

```powershell
sdkmanager --sdk_root="$env:ANDROID_HOME" --install `
  "platform-tools" "platforms;android-36" "build-tools;36.0.0" "ndk;28.2.13676358"
sdkmanager --licenses
flutter doctor --android-licenses
flutter config --jdk-dir "$env:JAVA_HOME"
flutter doctor -v
```

The Android project uses Gradle 9.3.1, Android Gradle Plugin 9.1.1, and Kotlin
Gradle Plugin 2.4.10. Flutter 3.50 requires at least AGP 9.1.1 and Kotlin
Gradle Plugin 2.4.10; the initially configured versions were below those build
requirements. Gradle 9.3.1 meets Flutter's minimum supported version. The
wrapper downloads Gradle from the official distribution URL on first use; no
manual Gradle cache setup is needed. Java 21 runs Gradle, while Android source
and Kotlin bytecode target Java 17.

## Flutter commands

From `mobile/`, run:

```sh
flutter pub get
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --release
flutter build ios --no-codesign
```

The release APK is written to
`build/app/outputs/flutter-apk/app-release.apk`. The iOS build command requires
macOS and Xcode.
