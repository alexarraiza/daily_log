import 'package:daily_log/logic/log_tags/log_tags_cubit.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:daily_log/data/models/log_tag.model.dart';

import '../../mocks/mock_log_tag_repository.dart';

void main() {
  group('LogTagsCubit', () {
    LogTagsCubit logTagsCubit;
    MockLogTagRepository mockLogTagRepository;

    LogTagModel mockTag = LogTagModel(
      'test',
      Colors.red,
      DateTime.now(),
      DateTime.now(),
      id: 1,
    );

    setUp(() {
      mockLogTagRepository = MockLogTagRepository();
      logTagsCubit = LogTagsCubit(mockLogTagRepository);
      reset(mockLogTagRepository);
    });

    test('initial state is LogTagInitial', () {
      expect(logTagsCubit.state, LogTagsInitial());
    });

    blocTest(
      'emits ErrorFetchingTags if fetching tags fails',
      build: () => logTagsCubit,
      act: (LogTagsCubit cubit) {
        when(mockLogTagRepository.fetchLogTags()).thenThrow(Error());
        cubit.fetchTags();
      },
      expect: [FetchingTags(), ErrorFetchingTags()],
    );

    blocTest(
      'emits LogTagsFetched if fetching tags succeeds',
      build: () => logTagsCubit,
      act: (LogTagsCubit cubit) {
        when(mockLogTagRepository.fetchLogTags())
            .thenAnswer((realInvocation) => Future(() => List<LogTagModel>()..add(mockTag)));
        cubit.fetchTags();
      },
      expect: [
        FetchingTags(),
        LogTagsFetched([mockTag])
      ],
    );

    blocTest(
      'emits LogTagDeleted after successfully deleting a tag',
      build: () => logTagsCubit,
      act: (LogTagsCubit cubit) {
        cubit.deleteTag(mockTag);
      },
      expect: [
        LogTagDeleted(mockTag),
      ],
    );

    blocTest(
      'emits ErrorDeletingTag after failing to delete a tag',
      build: () => logTagsCubit,
      act: (LogTagsCubit cubit) {
        when(mockLogTagRepository.deleteLogTag(mockTag)).thenThrow(Error());
        cubit.deleteTag(mockTag);
      },
      expect: [
        ErrorDeletingTag(),
      ],
    );
  });
}
