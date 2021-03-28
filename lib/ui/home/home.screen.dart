import 'dart:ui';

import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:daily_log/logic/log_entries_by_date/log_entries_by_date_cubit.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:daily_log/ui/common/our_app_bar.dart';
import 'package:daily_log/ui/home/widgets/log_entry_form.dart';
import 'package:daily_log/ui/home/widgets/log_entry_list.dart';
import 'package:daily_log/ui/settings/settings.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LogEntriesCubit>(context).fetchLogEntries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogEntriesCubit, LogEntriesState>(
      listener: (context, state) {
        if (state is LogEntryDeleted) {
          BlocProvider.of<LogEntriesCubit>(context).fetchLogEntries();
        }
      },
      child: Scaffold(
        appBar: buildOurAppBar(
          Text(AppLocalizations.of(context)!.home_screen_title),
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
          label: Text(AppLocalizations.of(context)!.home_screen_new_entry),
          icon: Icon(Icons.add),
          onPressed: () => _addOrEditEntry(null),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LogEntriesCubit, LogEntriesState>(
      builder: (context, entriesState) {
        return BlocBuilder<LogEntriesByDateCubit, LogEntriesByDateState>(
          builder: (context, filteredEntriesState) {
            if (entriesState is LogEntriesFetched && filteredEntriesState is LogEntriesByDateLoaded) {
              print(BlocProvider.of<LogEntriesByDateCubit>(context).getDateSelected());
              return Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Material(
                    //   color: Colors.black,
                    //   elevation: 2,
                    //   child: Calendar(
                    //     Platform.localeName,
                    //     onDaySelected: (day) => BlocProvider.of<LogEntriesByDateCubit>(context).getEntriesByDate(day),
                    //     focusedDay: BlocProvider.of<LogEntriesByDateCubit>(context).getDateSelected(),
                    //     logEntries: entriesState.logEntries,
                    //   ),
                    // ),
                    Expanded(
                      flex: 2,
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
              return Center(child: Text(AppLocalizations.of(context)!.placeholder_unexpected_state));
            }
          },
        );
      },
    );
  }

  void _addOrEditEntry(LogEntryModel? entry) {
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
            child: IconButton(
              icon: Icon(
                Icons.today_outlined,
                color: Colors.red,
              ),
              onPressed: () => BlocProvider.of<LogEntriesByDateCubit>(context).getEntriesByDate(DateTime.now()),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
