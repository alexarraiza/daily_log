part of 'log_tag_cubit.dart';

abstract class LogTagState extends Equatable {
  const LogTagState();
}

class LogTagInitial extends LogTagState {
  @override
  List<Object> get props => [];
}

class SavingLogTag extends LogTagState {
  @override
  List<Object> get props => [];
}

class LogTagSaved extends LogTagState {
  final LogTagModel tag;

  LogTagSaved(this.tag);
  @override
  List<Object> get props => [this.tag];
}

class LogTagSaveError extends LogTagState {
  final LogTagModel tag;

  LogTagSaveError(this.tag);
  @override
  List<Object> get props => [this.tag];
}
