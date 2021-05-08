import 'package:bloc_test/bloc_test.dart';
import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mock_log_tag.dart';
import '../../mocks/mock_log_tag_repository.dart';

void main() {
  group('LogTagsCubit', () {
    late LogTagsCubit logTagsCubit;
    late MockLogTagRepository mockLogTagRepository;

    setUp(() {
      mockLogTagRepository = MockLogTagRepository();
      logTagsCubit = LogTagsCubit(mockLogTagRepository);
      reset(mockLogTagRepository);
    });

    test('initial state is LogTagInitial', () {
      expect(logTagsCubit.state, LogTagsInitial());
    });
    group('fetchTags', () {
      blocTest(
        'emits ErrorFetchingTags if fetching tags fails',
        build: () => logTagsCubit,
        act: (LogTagsCubit cubit) {
          when(mockLogTagRepository.fetchLogTags()).thenThrow(Error());
          cubit.fetchTags();
        },
        expect: () => [FetchingTags(), ErrorFetchingTags()],
      );

      blocTest(
        'emits LogTagsFetched if fetching tags succeeds',
        build: () => logTagsCubit,
        act: (LogTagsCubit cubit) {
          when(mockLogTagRepository.fetchLogTags())
              .thenAnswer((realInvocation) => Future(() => [mockLogTag]));
          cubit.fetchTags();
        },
        expect: () => [
          FetchingTags(),
          LogTagsFetched([mockLogTag])
        ],
      );
    });
    group('deleteTag', () {
      blocTest(
        'emits LogTagDeleted after successfully deleting a tag',
        build: () => logTagsCubit,
        act: (LogTagsCubit cubit) {
          cubit.deleteTag(mockLogTag);
        },
        expect: () => [
          LogTagDeleted(mockLogTag),
        ],
      );

      blocTest(
        'emits ErrorDeletingTag after failing to delete a tag',
        build: () => logTagsCubit,
        act: (LogTagsCubit cubit) {
          when(mockLogTagRepository.deleteLogTag(mockLogTag)).thenThrow(Error());
          cubit.deleteTag(mockLogTag);
        },
        expect: () => [
          ErrorDeletingTag(),
        ],
      );
    });
  });
}
