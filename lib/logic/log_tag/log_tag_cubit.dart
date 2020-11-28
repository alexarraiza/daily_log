import 'package:bloc/bloc.dart';
import 'package:daily_log/data/repositories/log_tag.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

part 'log_tag_state.dart';

class LogTagCubit extends Cubit<LogTagState> {
  final LogTagRepository _logTagRepository;

  LogTagCubit(this._logTagRepository) : super(LogTagInitial());

  void saveLogTag(LogTagModel tag) async {
    emit(SavingLogTag());
    try {
      emit(LogTagSaved(await this._logTagRepository.saveLogTag(tag)));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(LogTagSaveError(tag));
    }
  }

  void resetState() => emit(LogTagInitial());
}
