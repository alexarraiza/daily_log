import 'package:daily_log/data/data_providers/base_data_providers/log_entry.base_data_provider.dart';
import 'package:daily_log/data/models/log_entry.model.dart';

class LogEntryRepository {
  final LogEntryBaseDataProvider _logEntryDataProvider;

  LogEntryRepository(this._logEntryDataProvider);

  Future<List<LogEntryModel>> fetchLogEntries() async {
    return const [];
  }
}
