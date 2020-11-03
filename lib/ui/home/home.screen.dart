import 'dart:io';
import 'dart:ui';

import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:daily_log/logic/log_entries_by_date/log_entries_by_date_cubit.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:daily_log/ui/home/widgets/log_entry_list.dart';
import 'package:daily_log/ui/home/widgets/log_entry_form.dart';
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
        leading: _buildTodayButton(),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(AppLocalizations.of(context).home_screen_new_entry),
        icon: Icon(Icons.add),
        onPressed: () => _addOrEditEntry(null),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LogEntriesCubit, LogEntriesState>(
      builder: (context, entriesState) {
        return BlocBuilder<LogEntriesByDateCubit, LogEntriesByDateState>(
          builder: (context, filteredEntriesState) {
            if (entriesState is LogEntriesFetched && filteredEntriesState is LogEntriesByDateLoaded) {
              return Material(
                child: Column(
                  children: [
                    Material(
                      elevation: 2,
                      child: Calendar(
                        Platform.localeName,
                        _calendarController,
                        onDaySelected: (day, events, holidays) =>
                            BlocProvider.of<LogEntriesByDateCubit>(context).getEntriesByDate(day),
                        initialDateSelected: BlocProvider.of<LogEntriesByDateCubit>(context).getDateSelected(),
                        logEntries: entriesState.logEntries,
                      ),
                    ),
                    Expanded(
                      child: LogEntryList(
                        filteredEntriesState.entries,
                        onTapItem: _addOrEditEntry,
                        onDeleteItem: (entry) => BlocProvider.of<LogEntriesCubit>(context).deleteEntry(entry),
                        shrinkWrap: false,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text(AppLocalizations.of(context).placeholder_unexpected_state));
            }
          },
        );
      },
    );
  }

  void _addOrEditEntry(LogEntryModel entry) {
    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          LogEntryForm(
            BlocProvider.of<LogEntriesByDateCubit>(context).getDateSelected(),
            logEntry: entry,
          ),
        ],
      ),
    ).then((_) {
      BlocProvider.of<LogEntryCubit>(context).resetState();
      BlocProvider.of<LogEntriesCubit>(context).fetchLogEntries();
    });
  }

  Widget _buildTodayButton() {
    return BlocBuilder<LogEntriesByDateCubit, LogEntriesByDateState>(
      builder: (context, state) {
        if (state is LogEntriesByDateLoaded &&
            (state.date.day != DateTime.now().day ||
                state.date.month != DateTime.now().month ||
                state.date.year != DateTime.now().year)) {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: CircleAvatar(
              backgroundColor: Colors.red.withOpacity(.7),
              child: IconButton(
                  icon: Icon(
                    Icons.today_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _calendarController.setSelectedDay(DateTime.now(), runCallback: true);
                  }),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
