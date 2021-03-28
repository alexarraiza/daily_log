import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'base_data_providers/log_entry.base_data_provider.dart';
import 'base_data_providers/log_tag.base_data_provider.dart';

class SembastDataProvider implements LogEntryBaseDataProvider, LogTagBaseDataProvider {
  static const String DB_NAME = 'dailylog.db';
  static const String STORE_TAGS = 'STORE_TAGS';
  static const String STORE_ENTRIES = 'STORE_ENTRIES';

  static StoreRef storeTags = StoreRef<int, LogTagModel>(STORE_TAGS);
  static StoreRef storeEntries = StoreRef<int, LogEntryModel>(STORE_ENTRIES);

  Database? _appDatabase;

  Future<String> _getDatabasePath() async {
    //get application directory
    final directory = await getApplicationDocumentsDirectory();

    //construct path
    final dbPath = join(directory.path, DB_NAME);

    return dbPath;
  }

  Future<Database> _createDatabase() async {
    //open database
    return await databaseFactoryIo.openDatabase(await _getDatabasePath(), mode: DatabaseMode.neverFails);
  }

  Future<Database> _getDatabase() async {
    if (this._appDatabase == null) {
      this._appDatabase = await _createDatabase();
    }
    return this._appDatabase!;
  }

  Future<void> closeDatabase() async {
    if (this._appDatabase == null) {
      await this._appDatabase!.close();
      this._appDatabase = null;
    }
  }

  Future<void> deleteRecord(StoreRef store, int id) async {
    await store.record(id).delete(await _getDatabase());
  }

  Future<Map> getRecord(StoreRef store, int id) async {
    return await (store.record(id).get(await _getDatabase()));
  }

  Future<List> getAllRecords(StoreRef store) async {
    return (await store.find(await _getDatabase())).map((e) => e.value).toList();
  }

  Future<int> addRecord(StoreRef store, Map<String, dynamic> json) async {
    return await (store.add(await _getDatabase(), json));
  }

  Future<void> putRecord(StoreRef store, int id, Map<String, dynamic> json) async {
    await store.record(id).put(await _getDatabase(), json);
  }

  Future<void> clearStore(StoreRef store) async {
    await store.delete(await _getDatabase());
  }

  @override
  Future<void> deleteLogEntry(int id) async {
    return await deleteRecord(storeEntries, id);
  }

  @override
  Future<void> deleteLogTag(int id) async {
    return await deleteRecord(storeTags, id);
  }

  @override
  Future<List> fetchLogEntries() async {
    return await getAllRecords(storeEntries);
  }

  @override
  Future<List> fetchLogTags() async {
    return await getAllRecords(storeTags);
  }

  @override
  Future<int> saveLogEntry(Map<String, dynamic> json) async {
    return await addRecord(storeEntries, json);
  }

  @override
  Future<int> saveLogTag(Map<String, dynamic> json) async {
    return await addRecord(storeTags, json);
  }

  @override
  Future<void> updateLogEntry(int id, Map<String, dynamic> json) async {
    return await putRecord(storeEntries, id, json);
  }

  @override
  Future<void> updateLogTag(int id, Map<String, dynamic> json) async {
    return await putRecord(storeTags, id, json);
  }
}
