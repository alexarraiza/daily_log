import 'package:bloc/bloc.dart';
import 'package:daily_log/data/repositories/log_tag.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

part 'log_tags_state.dart';

class LogTagsCubit extends Cubit<LogTagsState> {
  final LogTagRepository _logTagRepository;

  LogTagsCubit(this._logTagRepository) : super(LogTagsInitial());

  Future<void> fetchTags() async {
    emit(FetchingTags());
    try {
      emit(LogTagsFetched(await this._logTagRepository.fetchLogTags()));
    } catch (_) {
      emit(ErrorFetchingTags());
    }
  }

  Future<void> deleteTag(LogTagModel tag) async {
    try {
      await this._logTagRepository.deleteLogTag(tag);
      emit(LogTagDeleted(tag));
    } catch (_) {
      emit(ErrorDeletingTag());
    }
  }
}
