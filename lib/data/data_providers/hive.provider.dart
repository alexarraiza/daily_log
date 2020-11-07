import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'base_data_providers/log_entry.base_data_provider.dart';
import 'base_data_providers/log_tag.base_data_provider.dart';

class HiveDataProvider implements LogEntryBaseDataProvider, LogTagBaseDataProvider {
  static const String BOX_TAGS = 'BOX_TAGS';
  static const String BOX_ENTRIES = 'BOX_ENTRIES';

  Future<Box> _getBox(String name) async {
    await Hive.initFlutter();
    return await Hive.openBox(name);
  }

  @override
  Future<void> deleteLogEntry(int id) async {
    return (await _getBox(BOX_ENTRIES)).delete(id);
  }

  @override
  Future<void> deleteLogTag(int id) async {
    return (await _getBox(BOX_TAGS)).delete(id);
  }

  @override
  Future<List> fetchLogEntries() async {
    return (await _getBox(BOX_ENTRIES)).values.toList();
  }

  @override
  Future<List> fetchLogTags() async {
    return (await _getBox(BOX_TAGS)).values.toList();
  }

  @override
  Future<int> saveLogEntry(Map<String, dynamic> json) async {
    return (await _getBox(BOX_ENTRIES)).add(json);
  }

  @override
  Future<int> saveLogTag(Map<String, dynamic> json) async {
    return (await _getBox(BOX_TAGS)).add(json);
  }

  @override
  Future<void> updateLogEntry(int id, Map<String, dynamic> json) async {
    return (await _getBox(BOX_ENTRIES)).put(id, json);
  }

  @override
  Future<void> updateLogTag(int id, Map<String, dynamic> json) async {
    return (await _getBox(BOX_TAGS)).put(id, json);
  }
}
