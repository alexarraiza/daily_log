abstract class LogTagBaseDataProvider {
  Future<List<dynamic>> fetchLogTags();
  Future<int> saveLogTag(Map<String, dynamic> json);
  Future<void> updateLogTag(int id, Map<String, dynamic> json);
  Future<void> deleteLogTag(int id);
}
