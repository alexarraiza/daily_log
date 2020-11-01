part of 'log_tags_cubit.dart';

abstract class LogTagsState extends Equatable {
  const LogTagsState();
}

class LogTagsInitial extends LogTagsState {
  @override
  List<Object> get props => [];
}

class LogTagsFetched extends LogTagsState {
  final List<LogTagModel> tags;

  LogTagsFetched(this.tags);

  @override
  List<Object> get props => [this.tags];
}
