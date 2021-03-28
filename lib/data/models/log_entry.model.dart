import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'log_tag.model.dart';

part 'log_entry.model.g.dart';

@JsonSerializable()
class LogEntryModel extends Equatable {
  final int? id;
  @JsonKey()
  final String entry;
  @JsonKey(toJson: tagToJson)
  final LogTagModel? tag;
  @JsonKey()
  final DateTime assignedDateTime;
  @JsonKey()
  final DateTime createDateTime;
  @JsonKey()
  final DateTime editDateTime;

  LogEntryModel(
    this.entry,
    this.createDateTime,
    this.editDateTime,
    this.assignedDateTime, {
    this.id,
    this.tag,
  });

  factory LogEntryModel.fromJson(json) => _$LogEntryModelFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$LogEntryModelToJson(this);

  LogEntryModel copyWith({
    entry,
    createDateTime,
    editDateTime,
    assignedDateTime,
    id,
    tag,
  }) {
    return LogEntryModel(
      entry ?? this.entry,
      createDateTime ?? this.createDateTime,
      editDateTime ?? this.editDateTime,
      assignedDateTime ?? this.assignedDateTime,
      tag: tag ?? this.tag,
      id: id ?? this.id,
    );
  }

  static Map<String, dynamic>? tagToJson(LogTagModel? tags) => tags?.toJson();

  @override
  List<Object?> get props =>
      [this.id, this.entry, this.tag, this.createDateTime, this.editDateTime, this.assignedDateTime];

  @override
  String toString() => 'LogEntry { id: $id }';
}
