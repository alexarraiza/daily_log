import 'package:daily_log/ui/home/home.screen.dart';
import 'package:daily_log/ui/settings/settings.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyLog',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomeScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: (settings) {
        var routes = <String, WidgetBuilder>{
          HomeScreen.routeName: (context) => HomeScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        };
        WidgetBuilder routeBuilder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => routeBuilder(context), settings: settings);
      },
    );
  }
}
