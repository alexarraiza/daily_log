import 'package:bloc_test/bloc_test.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mock_log_entry.dart';
import '../../mocks/mock_log_entry_repository.dart';

void main() {
  group('Log Entries Cubit', () {
    LogEntriesCubit logEntriesCubit;
    MockLogEntryRepository mockLogEntryRepository;

    setUp(() {
      mockLogEntryRepository = MockLogEntryRepository();
      logEntriesCubit = LogEntriesCubit(mockLogEntryRepository);
      reset(mockLogEntryRepository);
    });

    test('initial state is LogTagInitial', () {
      expect(logEntriesCubit.state, LogEntriesInitial());
    });
    group('fetchLogEntries', () {
      blocTest(
        'emits ErrorFetchingEntries if fetching entries fails',
        build: () => logEntriesCubit,
        act: (LogEntriesCubit cubit) {
          when(mockLogEntryRepository.fetchLogEntries()).thenThrow(Error());
          cubit.fetchLogEntries();
        },
        expect: [FetchingLogEntries(), ErrorFetchingEntries()],
      );

      blocTest(
        'emits LogEntriesFetched if fetching entries succeeds',
        build: () => logEntriesCubit,
        act: (LogEntriesCubit cubit) {
          when(mockLogEntryRepository.fetchLogEntries())
              .thenAnswer((realInvocation) => Future(() => [mockLogEntry]));
          cubit.fetchLogEntries();
        },
        expect: [
          FetchingLogEntries(),
          LogEntriesFetched([mockLogEntry])
        ],
      );
    });
    group('deleteEntry', () {
      blocTest(
        'emits LogEntryDeleted after successfully deleting an entry',
        build: () => logEntriesCubit,
        act: (LogEntriesCubit cubit) {
          cubit.deleteEntry(mockLogEntry);
        },
        expect: [
          LogEntryDeleted(mockLogEntry),
        ],
      );

      blocTest(
        'emits ErrorDeletingTag after failing to delete a tag',
        build: () => logEntriesCubit,
        act: (LogEntriesCubit cubit) {
          when(mockLogEntryRepository.deleteLogEntry(mockLogEntry)).thenThrow(Error());
          cubit.deleteEntry(mockLogEntry);
        },
        expect: [
          ErrorDeletingEntry(),
        ],
      );
    });
  });
}
