// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogEntryModel _$LogEntryModelFromJson(Map<String, dynamic> json) {
  return LogEntryModel(
    json['entry'] as String,
    DateTime.parse(json['createDateTime'] as String),
    DateTime.parse(json['editDateTime'] as String),
    DateTime.parse(json['assignedDateTime'] as String),
    id: json['id'] as int,
    tag: LogTagModel.fromJson(json['tag']),
  );
}

Map<String, dynamic> _$LogEntryModelToJson(LogEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entry': instance.entry,
      'tag': LogEntryModel.tagToJson(instance.tag),
      'assignedDateTime': instance.assignedDateTime.toIso8601String(),
      'createDateTime': instance.createDateTime.toIso8601String(),
      'editDateTime': instance.editDateTime.toIso8601String(),
    };
