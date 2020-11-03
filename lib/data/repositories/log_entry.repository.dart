import 'package:daily_log/data/data_providers/base_data_providers/log_entry.base_data_provider.dart';
import 'package:daily_log/data/models/log_entry.model.dart';

class LogEntryRepository {
  final LogEntryBaseDataProvider _logEntryDataProvider;

  LogEntryRepository(this._logEntryDataProvider);

  Future<List<LogEntryModel>> fetchLogEntries() async {
    var entriesResult = await this._logEntryDataProvider.fetchLogEntries();
    return entriesResult.map((entry) => LogEntryModel.fromJson(entry.value).copyWith(id: entry.key)).toList();
  }

  Future<LogEntryModel> saveLogEntry(LogEntryModel logEntry) async {
    if (logEntry.id == null) {
      int savedId = await this._logEntryDataProvider.saveLogEntry(logEntry.toJson());
      return logEntry.copyWith(id: savedId);
    } else {
      await this._logEntryDataProvider.updateLogEntry(logEntry.id, logEntry.toJson());
      return logEntry;
    }
  }

  Future<LogEntryModel> deleteLogEntry(LogEntryModel logEntry) async {
    await this._logEntryDataProvider.deleteLogEntry(logEntry.id);
    return logEntry;
  }
}
