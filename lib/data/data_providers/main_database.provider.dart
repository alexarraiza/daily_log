import 'dart:io';

import 'package:daily_log/data/data_providers/base_data_providers/log_entry.base_data_provider.dart';
import 'package:daily_log/data/data_providers/base_data_providers/log_tag.base_data_provider.dart';
import 'package:daily_log/data/data_providers/tables/log_entries.table.dart';
import 'package:daily_log/data/data_providers/tables/log_tags.table.dart';
import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/data/models/log_tag.model.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'main_database.provider.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'main_database.sqlite'));
    return VmDatabase(file, logStatements: kDebugMode);
  });
}

@UseMoor(tables: [LogTags, LogEntries])
class MainDatabase extends _$MainDatabase implements LogEntryBaseDataProvider, LogTagBaseDataProvider {
  MainDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<int> deleteLogEntry(int id) async {
    return await (delete(logEntries)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> deleteLogTag(int id) async {
    return await (delete(logTags)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<LogEntryModel>> fetchLogEntries() async {
    return await Future.wait((await select(logEntries).get())
        .map((ent) async => LogEntryModel(
              ent.entry,
              ent.createdAt,
              ent.editedAt,
              ent.assignedAt,
              id: ent.id,
              tag: ent.tag != null ? await fetchLogTagById(ent.tag!) : null,
            ))
        .toList());
  }

  @override
  Future<List<LogTagModel>> fetchLogTags() async {
    return (await select(logTags).get())
        .map((t) => LogTagModel(
              t.tag,
              LogTagModel.colorFromJson(t.color),
              t.createdAt,
              t.editedAt,
              id: t.id,
            ))
        .toList();
  }

  @override
  Future<int> saveLogEntry(LogEntryModel entry) async {
    LogEntriesCompanion entryToInsert = LogEntriesCompanion.insert(
      assignedAt: entry.assignedDateTime,
      createdAt: entry.createDateTime,
      editedAt: entry.editDateTime,
      entry: entry.entry,
      tag: Value(entry.tag?.id),
    );

    if (entry.id != null) entryToInsert = entryToInsert.copyWith(id: Value(entry.id));
    return await into(logEntries).insertOnConflictUpdate(entryToInsert);
  }

  @override
  Future<int> saveLogTag(LogTagModel tag) async {
    LogTagsCompanion tagToInsert = LogTagsCompanion.insert(
      tag: tag.tag,
      editedAt: tag.editDateTime,
      createdAt: tag.createDateTime,
      color: LogTagModel.colorToJson(tag.color),
    );

    if (tag.id != null) tagToInsert = tagToInsert.copyWith(id: Value(tag.id));
    return await into(logTags).insertOnConflictUpdate(tagToInsert);
  }

  @override
  Future<LogTagModel?> fetchLogTagById(int id) async {
    LogTag? tagFetched = await (select(logTags)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (tagFetched == null) {
      return null;
    } else {
      return LogTagModel(
          tagFetched.tag, LogTagModel.colorFromJson(tagFetched.color), tagFetched.createdAt, tagFetched.editedAt,
          id: tagFetched.id);
    }
  }
}
