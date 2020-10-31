import 'package:equatable/equatable.dart';

import 'log_tag.model.dart';

class LogEntryModel extends Equatable {
  final int id;
  final String entry;
  final List<LogTagModel> tags;
  final DateTime createDateTime;
  final DateTime editDateTime;

  LogEntryModel(this.id, this.entry, this.tags, this.createDateTime, this.editDateTime);

  @override
  List<Object> get props => [this.id, this.entry, this.tags, this.createDateTime, this.editDateTime];

  @override
  String toString() => 'LogEntry { id: $id }';
}
