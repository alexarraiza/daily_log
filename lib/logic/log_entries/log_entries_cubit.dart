import 'package:bloc/bloc.dart';
import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/data/repositories/log_entry.repository.dart';
import 'package:equatable/equatable.dart';

part 'log_entries_state.dart';

class LogEntriesCubit extends Cubit<LogEntriesState> {
  final LogEntryRepository _logEntryRepository;
  LogEntriesCubit(this._logEntryRepository) : super(LogEntriesInitial());

  void fetchLogEntries() async => emit(LogEntriesFetched(await _logEntryRepository.fetchLogEntries()));
}
