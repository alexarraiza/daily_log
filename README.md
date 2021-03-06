# daily_log

A simple and private note taking app.

![Dart CI](https://github.com/alexarraiza/daily_log/workflows/Dart%20CI/badge.svg?branch=master)
[![Codemagic build status](https://api.codemagic.io/apps/5fb12acd605096c8217aaa11/5fb12acd605096c8217aaa10/status_badge.svg)](https://codemagic.io/apps/5fb12acd605096c8217aaa11/5fb12acd605096c8217aaa10/latest_build)

## Getting Started

### Must Do

- Android & iOS

  - To successfully run the project on an emulator/device/CI you must run the builder to generate all the necessary json mappers:

  ```bash
  flutter packages pub run build_runner build --delete-conflicting-outputs
  ```

- Android

  - Add a valid `google-services.json` to `android/app`

- iOS
  - Add a valid `GoogleService_Info.plist` to `ios/Runner`

### Optional

- [Localazy](https://localazy.com/) - the gratest way to implement translations to any app
  - If you want to help with translations of my implementation you can [go here](https://localazy.com/p/dailylog) to participate
  - If you want to use localazy to translate the app on your own, you can add a file called `localazy.json` based on `localazy-example.json` on the root folder of the project

## RoadMap

### WIP

- Implement testing

### TODO

- Optimize database access for data scalability
- Publish it fully to Android Play Store (currently it's in internal testing)
- Publish it to iOS App Store (need to get an iOS dev license :money_with_wings: :money_with_wings:)
