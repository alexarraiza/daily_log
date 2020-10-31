import 'package:bloc/bloc.dart';
import 'package:daily_log/data/repositories/log_tag.repository.dart';
import 'package:equatable/equatable.dart';

part 'log_tags_state.dart';

class LogTagsCubit extends Cubit<LogTagsState> {
  final LogTagRepository _logTagRepository;

  LogTagsCubit(this._logTagRepository) : super(LogTagsInitial());
}
