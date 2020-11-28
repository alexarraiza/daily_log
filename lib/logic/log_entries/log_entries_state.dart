part of 'log_entries_cubit.dart';

abstract class LogEntriesState extends Equatable {
  const LogEntriesState();
}

class LogEntriesInitial extends LogEntriesState {
  @override
  List<Object> get props => [];
}

class FetchingLogEntries extends LogEntriesState {
  @override
  List<Object> get props => [];
}

class LogEntriesFetched extends LogEntriesState {
  final List<LogEntryModel> logEntries;

  LogEntriesFetched(this.logEntries);

  @override
  List<Object> get props => [this.logEntries];
}

class ErrorFetchingEntries extends LogEntriesState {
  ErrorFetchingEntries();

  @override
  List<Object> get props => [];
}

class LogEntryDeleted extends LogEntriesState {
  final LogEntryModel entry;
  LogEntryDeleted(this.entry);

  @override
  List<Object> get props => [this.entry];
}

class ErrorDeletingEntry extends LogEntriesState {
  ErrorDeletingEntry();

  @override
  List<Object> get props => [];
}
