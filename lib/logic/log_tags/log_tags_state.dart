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

class FetchingTags extends LogTagsState {
  FetchingTags();

  @override
  List<Object> get props => [];
}

class ErrorFetchingTags extends LogTagsState {
  ErrorFetchingTags();

  @override
  List<Object> get props => [];
}

class LogTagDeleted extends LogTagsState {
  final LogTagModel tagDeleted;
  LogTagDeleted(this.tagDeleted);

  @override
  List<Object> get props => [this.tagDeleted];
}

class ErrorDeletingTag extends LogTagsState {
  ErrorDeletingTag();

  @override
  List<Object> get props => [];
}
