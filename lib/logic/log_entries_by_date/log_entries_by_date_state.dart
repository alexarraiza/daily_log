part of 'log_entries_by_date_cubit.dart';

abstract class LogEntriesByDateState extends Equatable {
  const LogEntriesByDateState();
}

class LogEntriesByDateInitial extends LogEntriesByDateState {
  @override
  List<Object> get props => [];
}

class LogEntriesByDateLoaded extends LogEntriesByDateState {
  final DateTime date;
  final List<LogEntryModel> entries;

  LogEntriesByDateLoaded(this.date, this.entries);

  @override
  List<Object> get props => [this.date, this.entries];
}
