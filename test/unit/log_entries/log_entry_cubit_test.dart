import 'package:bloc_test/bloc_test.dart';
import 'package:daily_log/logic/log_entry/log_entry_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mock_log_entry.dart';
import '../../mocks/mock_log_entry_repository.dart';

void main() {
  group('LogEntryCubit', () {
    LogEntryCubit logEntryCubit;
    MockLogEntryRepository mockLogEntryRepository;

    setUp(() {
      mockLogEntryRepository = MockLogEntryRepository();
      logEntryCubit = LogEntryCubit(mockLogEntryRepository);
      reset(mockLogEntryRepository);
    });

    test('initial state is LogEntryInitial', () {
      expect(logEntryCubit.state, LogEntryInitial());
    });

    group('resetState', () {
      blocTest(
        'resetState should return the bloc to its initial state',
        build: () => logEntryCubit,
        act: (LogEntryCubit cubit) => cubit.resetState(),
        expect: () => [LogEntryInitial()],
      );
    });

    group('saveLogEntry', () {
      blocTest(
        'saveLogEntry should emit LogEntrySaved after a successful save',
        build: () => logEntryCubit,
        act: (LogEntryCubit cubit) {
          when(mockLogEntryRepository.saveLogEntry(mockLogEntry))
              .thenAnswer((realInvocation) => Future(() => mockLogEntry));
          cubit.saveLogEntry(mockLogEntry);
        },
        expect: () => [SavingLogEntry(), LogEntrySaved(mockLogEntry)],
      );

      blocTest(
        'saveLogEntry should emit LogEntrySaveError after a failed save',
        build: () => logEntryCubit,
        act: (LogEntryCubit cubit) {
          when(mockLogEntryRepository.saveLogEntry(mockLogEntry)).thenThrow(Error());
          cubit.saveLogEntry(mockLogEntry);
        },
        expect: () => [SavingLogEntry(), LogEntrySaveError(mockLogEntry)],
      );
    });
  });
}
