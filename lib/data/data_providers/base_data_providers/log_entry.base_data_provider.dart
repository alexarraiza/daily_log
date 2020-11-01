abstract class LogEntryBaseDataProvider {
  Future<List<dynamic>> fetchLogEntries();
  Future<int> saveLogEntry(Map<String, dynamic> json);
  Future<void> updateLogEntry(int id, Map<String, dynamic> json);
}
