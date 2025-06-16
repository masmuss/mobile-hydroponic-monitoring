# Hydroponic IoT Monitoring

A Flutter project for hydroponic IoT monitoring.

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (usually included with Flutter)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- Device or emulator for testing

## Setup

1. **Clone the repository**
```sh
   git clone https://github.com/masmuss/mobile-hydroponic-monitoring.git
   cd mobile-hydroponic-monitoring
```

2. **Install dependencies**
```sh
   flutter pub get
```

3. **(Optional) Configure platforms**  
- For Android: Open `android` folder in Android Studio and run `flutter pub get`.
- For iOS: Open `ios` folder in Xcode and run `pod install`.

## **Running the App**
1. Start an emulator or connect a device  
2. Run the app
```sh
    flutter run
```

## Building for Release
- Android
```sh
    flutter build apk --release
```

- iOS
```sh
    flutter build ios --release
```

## Troubleshooting
Run `flutter doctor` to check for any missing dependencies.
Ensure your device/emulator is connected and recognized by Flutter.