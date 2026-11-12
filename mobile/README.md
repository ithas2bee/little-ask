# Little Ask Mobile

The Flutter application lives in this directory. The NestJS backend remains in
the repository's separate `backend/` directory.

From `mobile/`, use these commands:

```sh
flutter pub get
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk
flutter build ios --no-codesign
```

The iOS build command requires macOS and Xcode. Android builds require the
Android SDK.
