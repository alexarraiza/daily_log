import 'package:daily_log/data/data_providers/base_data_providers/log_tag.base_data_provider.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

class LogTagRepository {
  final LogTagBaseDataProvider _logTagDataProvider;

  LogTagRepository(this._logTagDataProvider);

  Future<List<LogTagModel>> fetchLogTags() async {
    var entriesResult = await this._logTagDataProvider.fetchLogTags();
    return entriesResult.map((entry) => LogTagModel.fromJson(entry.value).copyWith(id: entry.key)).toList();
  }

  Future<LogTagModel> deleteLogTag(LogTagModel tag) async {
    await this._logTagDataProvider.deleteLogTag(tag.id);
    return tag;
  }

  Future<LogTagModel> saveLogEntry(LogTagModel tag) async {
    if (tag.id == null) {
      int savedId = await this._logTagDataProvider.saveLogTag(tag.toJson());
      return tag.copyWith(id: savedId);
    } else {
      await this._logTagDataProvider.updateLogTag(tag.id, tag.toJson());
      return tag;
    }
  }
}
