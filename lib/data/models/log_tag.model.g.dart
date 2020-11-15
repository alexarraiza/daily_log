// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_tag.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogTagModel _$LogTagModelFromJson(Map<String, dynamic> json) {
  return LogTagModel(
    json['tag'] as String,
    LogTagModel.colorFromJson(json['color'] as int),
    json['createDateTime'] == null
        ? null
        : DateTime.parse(json['createDateTime'] as String),
    json['editDateTime'] == null
        ? null
        : DateTime.parse(json['editDateTime'] as String),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$LogTagModelToJson(LogTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'color': LogTagModel.colorToJson(instance.color),
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'editDateTime': instance.editDateTime?.toIso8601String(),
    };
