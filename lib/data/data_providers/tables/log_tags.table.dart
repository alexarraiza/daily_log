import 'package:moor/moor.dart';

@DataClassName('LogTag')
class LogTags extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tag => text()();

  IntColumn get color => integer()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get editedAt => dateTime()();
}
