import 'package:daily_log/data/data_providers/base_data_providers/log_tag.base_data_provider.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

class LogTagRepository {
  final LogTagBaseDataProvider _logTagDataProvider;

  LogTagRepository(this._logTagDataProvider);

  Future<List<LogTagModel>> fetchLogTags() async {
    return await this._logTagDataProvider.fetchLogTags();
  }

  Future<LogTagModel> deleteLogTag(LogTagModel tag) async {
    await this._logTagDataProvider.deleteLogTag(tag.id!);
    return tag;
  }

  Future<LogTagModel> saveLogTag(LogTagModel tag) async {
    return tag.copyWith(id: await this._logTagDataProvider.saveLogTag(tag));
  }
}
