import 'package:bloc/bloc.dart';
import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/data/repositories/log_entry.repository.dart';
import 'package:equatable/equatable.dart';

part 'log_entry_state.dart';

class LogEntryCubit extends Cubit<LogEntryState> {
  final LogEntryRepository _logEntryRepository;

  LogEntryCubit(this._logEntryRepository) : super(LogEntryInitial());

  void saveLogEntry(LogEntryModel logEntry) async {
    emit(SavingLogEntry());
    try {
      emit(LogEntrySaved(await this._logEntryRepository.saveLogEntry(logEntry)));
    } catch (_) {
      emit(LogEntrySaveError(logEntry));
    }
  }

  void resetState() => emit(LogEntryInitial());
}
