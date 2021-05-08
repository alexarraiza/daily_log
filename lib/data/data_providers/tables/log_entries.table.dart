import 'package:moor/moor.dart';

@DataClassName('LogEntry')
class LogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entry => text()();

  IntColumn get tag => integer().nullable()();

  DateTimeColumn get assignedAt => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get editedAt => dateTime()();
}
