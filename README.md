# daily_log

A new Flutter project.

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

- Implement testing
- Optimize database access
- Publish it fully to Android Play Store (currently is in internal testing)
