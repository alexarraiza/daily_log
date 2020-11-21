import 'package:daily_log/data/data_providers/sembast.provider.dart';
import 'package:daily_log/data/repositories/log_entry.repository.dart';
import 'package:daily_log/data/repositories/log_tag.repository.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:daily_log/logic/log_entries_by_date/log_entries_by_date_cubit.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:daily_log/logic/log_tag/log_tag_cubit.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:daily_log/ui/home/home.screen.dart';
import 'package:daily_log/ui/settings/settings.screen.dart';
import 'package:daily_log/ui/tag_manager/tag_manager.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DailyLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildProviders(
      _buildApp(),
    );
  }

  Widget _buildProviders(Widget app) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => SembastDataProvider(),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => LogEntryRepository(context.read<SembastDataProvider>()),
          ),
          RepositoryProvider(
            create: (context) => LogTagRepository(context.read<SembastDataProvider>()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LogEntriesCubit(RepositoryProvider.of<LogEntryRepository>(context)),
            ),
            BlocProvider(
              create: (context) => LogEntriesByDateCubit(BlocProvider.of<LogEntriesCubit>(context)),
            ),
            BlocProvider(
              create: (context) => LogTagsCubit(RepositoryProvider.of<LogTagRepository>(context)),
            ),
            BlocProvider(
              create: (context) => LogEntryCubit(RepositoryProvider.of<LogEntryRepository>(context)),
            ),
            BlocProvider(
              create: (context) => LogTagCubit(RepositoryProvider.of<LogTagRepository>(context)),
            ),
          ],
          child: app,
        ),
      ),
    );
  }

  MaterialApp _buildApp() {
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
          TagManagerScreen.routeName: (context) => TagManagerScreen(),
        };
        WidgetBuilder routeBuilder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => routeBuilder(context), settings: settings);
      },
    );
  }
}
