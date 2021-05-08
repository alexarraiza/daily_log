import 'package:daily_log/data/models/log_tag.model.dart';

abstract class LogTagBaseDataProvider {
  Future<List<LogTagModel>> fetchLogTags();

  Future<LogTagModel?> fetchLogTagById(int id);

  Future<int> saveLogTag(LogTagModel tag);

  Future<int> deleteLogTag(int id);
}
