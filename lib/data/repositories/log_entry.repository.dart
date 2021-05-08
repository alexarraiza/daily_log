import 'package:daily_log/data/data_providers/base_data_providers/log_entry.base_data_provider.dart';
import 'package:daily_log/data/models/log_entry.model.dart';

class LogEntryRepository {
  final LogEntryBaseDataProvider _logEntryDataProvider;

  LogEntryRepository(this._logEntryDataProvider);

  Future<List<LogEntryModel>> fetchLogEntries() async {
    return await this._logEntryDataProvider.fetchLogEntries();
  }

  Future<LogEntryModel> saveLogEntry(LogEntryModel logEntry) async {
    return logEntry.copyWith(id: await this._logEntryDataProvider.saveLogEntry(logEntry));
  }

  Future<LogEntryModel> deleteLogEntry(LogEntryModel logEntry) async {
    await this._logEntryDataProvider.deleteLogEntry(logEntry.id!);
    return logEntry;
  }
}
