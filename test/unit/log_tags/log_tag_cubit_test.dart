import 'package:bloc_test/bloc_test.dart';
import 'package:daily_log/logic/log_tag/log_tag_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_log_tag.dart';
import '../../mocks/mock_log_tag_repository.dart';

void main() {
  group('LogTagCubit', () {
    LogTagCubit logTagCubit;
    MockLogTagRepository mockLogTagRepository;

    setUp(() {
      mockLogTagRepository = MockLogTagRepository();
      logTagCubit = LogTagCubit(mockLogTagRepository);
      reset(mockLogTagRepository);
    });

    test('initial state is LogTagInitial', () {
      expect(logTagCubit.state, LogTagInitial());
    });

    blocTest(
      'resetState should return the bloc to its initial state',
      build: () => logTagCubit,
      act: (LogTagCubit cubit) => cubit.resetState(),
      expect: [LogTagInitial()],
    );

    blocTest(
      'saveLogTag should emit LogEntrySaved after a successful save',
      build: () => logTagCubit,
      act: (LogTagCubit cubit) {
        when(mockLogTagRepository.saveLogTag(mockLogTag)).thenAnswer((realInvocation) => Future(() => mockLogTag));
        cubit.saveLogTag(mockLogTag);
      },
      expect: [SavingLogTag(), LogTagSaved(mockLogTag)],
    );

    blocTest(
      'saveLogTag should emit LogEntrySaveError after a failed save',
      build: () => logTagCubit,
      act: (LogTagCubit cubit) {
        when(mockLogTagRepository.saveLogTag(mockLogTag)).thenThrow(Error());
        cubit.saveLogTag(mockLogTag);
      },
      expect: [SavingLogTag(), LogTagSaveError(mockLogTag)],
    );
  });
}
