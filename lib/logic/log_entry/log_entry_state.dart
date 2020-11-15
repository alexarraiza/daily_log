part of 'log_entry_cubit.dart';

abstract class LogEntryState extends Equatable {
  const LogEntryState();
}

class LogEntryInitial extends LogEntryState {
  @override
  List<Object> get props => [];
}

class LogEntrySaved extends LogEntryState {
  final LogEntryModel _logEntryModel;

  LogEntrySaved(this._logEntryModel);

  @override
  List<Object> get props => [this._logEntryModel];
}

class LogEntrySaveError extends LogEntryState {
  final LogEntryModel _logEntryModel;

  LogEntrySaveError(this._logEntryModel);

  @override
  List<Object> get props => [this._logEntryModel];
}
