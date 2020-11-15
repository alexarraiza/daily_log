part of 'log_entries_cubit.dart';

abstract class LogEntriesState extends Equatable {
  const LogEntriesState();
}

class LogEntriesInitial extends LogEntriesState {
  @override
  List<Object> get props => [];
}

class LogEntriesFetched extends LogEntriesState {
  final List<LogEntryModel> logEntries;

  LogEntriesFetched(this.logEntries);

  @override
  List<Object> get props => [this.logEntries];
}
