import 'package:equatable/equatable.dart';

class LogTagModel extends Equatable {
  final int id;
  final String tag;
  final DateTime createDateTime;
  final DateTime editDateTime;

  LogTagModel(this.id, this.tag, this.createDateTime, this.editDateTime);

  @override
  List<Object> get props => [this.id, this.tag, this.createDateTime, this.editDateTime];

  @override
  String toString() => 'LogTag { id: $id }';
}
