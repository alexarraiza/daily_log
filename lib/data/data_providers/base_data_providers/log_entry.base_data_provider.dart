import 'package:daily_log/data/models/log_entry.model.dart';

abstract class LogEntryBaseDataProvider {
  Future<List<LogEntryModel>> fetchLogEntries();

  Future<int> saveLogEntry(LogEntryModel entry);

  Future<int> deleteLogEntry(int id);
}
