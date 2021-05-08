import 'package:bloc_test/bloc_test.dart';
import 'package:daily_log/logic/log_entries/log_entries_cubit.dart';
import 'package:daily_log/logic/log_entries_by_date/log_entries_by_date_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mock_log_entry_repository.dart';

void main() {
  group('LogEntriesByDateCubit', () {
    LogEntriesCubit logEntriesCubit;
    late LogEntriesByDateCubit logEntriesByDateCubit;
    MockLogEntryRepository mockLogEntryRepository;

    setUp(() {
      mockLogEntryRepository = MockLogEntryRepository();
      logEntriesCubit = LogEntriesCubit(mockLogEntryRepository);
      logEntriesByDateCubit = LogEntriesByDateCubit(logEntriesCubit);
      reset(mockLogEntryRepository);
    });

    test('initial state is LogEntriesByDateInitial', () {
      expect(logEntriesByDateCubit.state, LogEntriesByDateInitial());
    });

    group('getEntriesByDate', () {
      blocTest(
        'emits LogEntriesByDateLoaded',
        build: () => logEntriesByDateCubit,
        act: (LogEntriesByDateCubit cubit) => cubit.getEntriesByDate(DateTime.now()),
        expect: () => [LogEntriesByDateLoaded],
      );
    });

    group('updatedEntries', () {});

    group('getDateSelected', () {});
  });
}
