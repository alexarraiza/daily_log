import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

import 'base_data_providers/log_entry.base_data_provider.dart';
import 'base_data_providers/log_tag.base_data_provider.dart';

class SembastDataProvider implements LogEntryBaseDataProvider, LogTagBaseDataProvider {
  static const String appDatabaseName = 'daily_log.db';
  static StoreRef logEntryStoreRef = StoreRef<int, LogEntryModel>('proyectos');
  static StoreRef logTagStoreRef = StoreRef<int, LogTagModel>('pdvs');

  Database _appDatabase;

  Future<Database> _createDatabase(String databaseName) async {
    //get application directory
    final directory = await getApplicationDocumentsDirectory();

    //construct path
    final dbPath = join(directory.path, databaseName);

    //open database
    return await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<Database> _getDatabase() async {
    if (this._appDatabase == null) {
      this._appDatabase = await _createDatabase(appDatabaseName);
    }
    return this._appDatabase;
  }

  @override
  Future<List<RecordSnapshot>> fetchLogEntries() async {
    return (await logEntryStoreRef.find(await this._getDatabase()));
  }

  @override
  Future<int> saveLogEntry(Map<String, dynamic> json) async {
    return await logEntryStoreRef.add(await this._getDatabase(), json);
  }

  @override
  Future<void> updateLogEntry(int id, Map<String, dynamic> json) async {
    await logEntryStoreRef.record(id).put(await this._getDatabase(), json);
  }

  @override
  Future<void> deleteLogEntry(int id) async {
    await logEntryStoreRef.record(id).delete(await this._getDatabase());
  }

  @override
  Future<List<dynamic>> fetchLogTags() async {
    return (await logTagStoreRef.find(await this._getDatabase()));
  }

  @override
  Future<int> saveLogTag(Map<String, dynamic> json) async {
    return await logTagStoreRef.add(await this._getDatabase(), json);
  }

  @override
  Future<void> updateLogTag(int id, Map<String, dynamic> json) async {
    await logTagStoreRef.record(id).put(await this._getDatabase(), json);
  }

  @override
  Future<void> deleteLogTag(int id) async {
    await logTagStoreRef.record(id).delete(await this._getDatabase());
  }
}
