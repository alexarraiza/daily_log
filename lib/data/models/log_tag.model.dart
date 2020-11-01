import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log_tag.model.g.dart';

@JsonSerializable()
class LogTagModel extends Equatable {
  final int id;
  @JsonKey()
  final String tag;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color color;
  @JsonKey()
  final DateTime createDateTime;
  @JsonKey()
  final DateTime editDateTime;

  LogTagModel(this.tag, this.color, this.createDateTime, this.editDateTime, {this.id});

  factory LogTagModel.fromJson(Map<String, dynamic> json) => _$LogTagModelFromJson(json);

  LogTagModel copyWith({
    id,
    tag,
    color,
    createDateTime,
    editDateTime,
  }) {
    return LogTagModel(
      tag ?? this.tag,
      color ?? this.color,
      createDateTime ?? this.createDateTime,
      editDateTime ?? this.editDateTime,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() => _$LogTagModelToJson(this);

  static int colorToJson(Color color) => color?.value;

  static Color colorFromJson(int colorValue) => colorValue != null ? Color(colorValue) : null;

  @override
  List<Object> get props => [this.id, this.tag, this.createDateTime, this.editDateTime, this.color];

  @override
  String toString() => 'LogTag { id: $id }';
}
