import 'package:daily_log/data/data_providers/base_data_providers/log_tag.base_data_provider.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

class LogTagRepository {
  final LogTagBaseDataProvider _logTagDataProvider;

  LogTagRepository(this._logTagDataProvider);

  Future<List<LogTagModel>> fetchLogTags() async {
    var entriesResult = await this._logTagDataProvider.fetchLogTags();
    print(entriesResult);
    return entriesResult.map((entry) => LogTagModel.fromJson(entry)).toList();
  }

  Future<LogTagModel> deleteLogTag(LogTagModel tag) async {
    await this._logTagDataProvider.deleteLogTag(tag.id);
    return tag;
  }

  Future<LogTagModel> saveLogEntry(LogTagModel tag) async {
    if (tag.id == null) {
      int savedId = await this._logTagDataProvider.saveLogTag(tag.toJson());
      LogTagModel tagWithId = tag.copyWith(id: savedId);
      await this._logTagDataProvider.updateLogTag(tagWithId.id, tagWithId.toJson());
      return tagWithId;
    } else {
      await this._logTagDataProvider.updateLogTag(tag.id, tag.toJson());
      return tag;
    }
  }
}
