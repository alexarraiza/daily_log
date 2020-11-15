// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogEntryModel _$LogEntryModelFromJson(Map<String, dynamic> json) {
  return LogEntryModel(
    json['entry'] as String,
    json['createDateTime'] == null
        ? null
        : DateTime.parse(json['createDateTime'] as String),
    json['editDateTime'] == null
        ? null
        : DateTime.parse(json['editDateTime'] as String),
    json['assignedDateTime'] == null
        ? null
        : DateTime.parse(json['assignedDateTime'] as String),
    id: json['id'] as int,
    tag: json['tag'] == null ? null : LogTagModel.fromJson(json['tag']),
  );
}

Map<String, dynamic> _$LogEntryModelToJson(LogEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entry': instance.entry,
      'tag': LogEntryModel.tagToJson(instance.tag),
      'assignedDateTime': instance.assignedDateTime?.toIso8601String(),
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'editDateTime': instance.editDateTime?.toIso8601String(),
    };
