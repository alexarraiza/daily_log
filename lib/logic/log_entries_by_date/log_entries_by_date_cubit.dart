import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:equatable/equatable.dart';

part 'log_entries_by_date_state.dart';

class LogEntriesByDateCubit extends Cubit<LogEntriesByDateState> {
  final LogEntriesCubit _logEntriesCubit;

  late StreamSubscription _logEntriesSubscription;
  List<LogEntryModel> _entries = const [];
  DateTime _dateTime = DateTime.now();

  LogEntriesByDateCubit(this._logEntriesCubit) : super(LogEntriesByDateInitial()) {
    if (_logEntriesCubit.state is LogEntriesFetched)
      _entries = (_logEntriesCubit.state as LogEntriesFetched).logEntries;
    _logEntriesSubscription = _logEntriesCubit.stream.listen((state) {
      if (state is LogEntriesFetched) {
        updatedEntries(state.logEntries);
      }
    });
  }

  void getEntriesByDate(DateTime dateTime) {
    this._dateTime = dateTime;
    emit(LogEntriesByDateLoaded(getDateSelected(), _filterLogEntriesByDate()));
  }

  void updatedEntries(List<LogEntryModel> entries) {
    this._entries = entries;
    emit(LogEntriesByDateLoaded(getDateSelected(), _filterLogEntriesByDate()));
  }

  DateTime getDateSelected() => this._dateTime;

  List<LogEntryModel> _filterLogEntriesByDate() => _entries
      .where((entry) =>
          entry.assignedDateTime.year == _dateTime.year &&
          entry.assignedDateTime.month == _dateTime.month &&
          entry.assignedDateTime.day == _dateTime.day)
      .toList();

  @override
  Future<void> close() {
    _logEntriesSubscription.cancel();
    return super.close();
  }
}
