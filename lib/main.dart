import 'dart:async';

import 'package:daily_log/ui/app/daily_log.app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kDebugMode)
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded<Future<void>>(() async {
    runApp(DailyLogApp());
  }, FirebaseCrashlytics.instance.recordError);
}
