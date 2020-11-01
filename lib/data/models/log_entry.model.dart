import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'log_tag.model.dart';

part 'log_entry.model.g.dart';

@JsonSerializable()
class LogEntryModel extends Equatable {
  final int id;
  @JsonKey()
  final String entry;
  @JsonKey(toJson: tagsToJson)
  final List<LogTagModel> tags;
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
    this.tags = const [],
  });

  factory LogEntryModel.fromJson(Map<String, dynamic> json) => _$LogEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogEntryModelToJson(this);

  LogEntryModel copyWith({
    entry,
    createDateTime,
    editDateTime,
    id,
    tags,
  }) {
    return LogEntryModel(
      entry ?? this.entry,
      createDateTime ?? this.createDateTime,
      editDateTime ?? this.editDateTime,
      assignedDateTime ?? this.assignedDateTime,
      tags: tags ?? this.tags,
      id: id ?? this.id,
    );
  }

  static List<dynamic> tagsToJson(List<LogTagModel> tags) => tags?.map((tag) => tag.toJson())?.toList();

  @override
  List<Object> get props =>
      [this.id, this.entry, this.tags, this.createDateTime, this.editDateTime, this.assignedDateTime];

  @override
  String toString() => 'LogEntry { id: $id }';
}
