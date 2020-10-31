import 'dart:io';

import 'package:badges/badges.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:daily_log/ui/home/widgets/log_entry_list.dart';
import 'package:daily_log/ui/settings/settings.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/calendar.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    BlocProvider.of<LogEntriesCubit>(context).fetchLogEntries();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).home_screen_title),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, SettingsScreen.routeName),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LogEntriesCubit, LogEntriesState>(
      builder: (context, state) {
        if (state is LogEntriesFetched) {
          return Column(
            children: [
              Material(
                elevation: 2,
                child: Calendar(
                  Platform.localeName,
                  _calendarController,
                ),
              ),
              Expanded(
                child: LogEntryList(state.logEntries),
              ),
            ],
          );
        } else {
          return Center(child: Text('Nothing to see here, move along...'));
        }
      },
    );
  }
}
