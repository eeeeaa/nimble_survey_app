import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/constants/app_constants.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/home/model/survey_list_ui_model.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/survey_list_view_model.dart';

import '../../../../mocks/mock_util.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late SurveyRepository mockSurveyRepository;

  late ProviderContainer container;

  setUp(() {
    mockSurveyRepository = MockSurveyRepository();

    container = ProviderContainer(
      overrides: [
        surveyRepositoryProvider.overrideWithValue(mockSurveyRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('When view model initialize, it returns initial SurveyListUiModel', () {
    // Given
    final expected = SurveyListUiModel(
      surveyList: List.empty(),
      currentIndex: 0,
      isLoading: true,
      hasMore: true,
      isFirstLoad: true,
    );

    // When
    final surveyListUiModel = container.read(surveyListViewModelProvider);

    // Then
    expect(surveyListUiModel, expected);
  });

  test(
    'When calling updateCurrentIndex, it update the current index value in SurveyListUiModel',
    () {
      // Given
      final expectedIndex = 1;
      final expected = SurveyListUiModel(
        surveyList: List.empty(),
        currentIndex: 0,
        isLoading: true,
        hasMore: true,
        isFirstLoad: true,
      );

      // When
      final surveyListUiModel = container.read(surveyListViewModelProvider);

      expect(surveyListUiModel, expected);

      container
          .read(surveyListViewModelProvider.notifier)
          .updateCurrentIndex(1);

      final updatedUiModel = container.read(surveyListViewModelProvider);

      expect(updatedUiModel.currentIndex, expectedIndex);
    },
  );

  test(
    'When calling initialLoad, it initially fetch survey list and update SurveyListUiModel',
    () async {
      // Given
      final expectedInitialState = SurveyListUiModel(
        surveyList: List.empty(),
        currentIndex: 0,
        isLoading: true,
        hasMore: true,
        isFirstLoad: true,
      );

      // When
      final surveyListUiModel = container.read(surveyListViewModelProvider);

      expect(surveyListUiModel, expectedInitialState);

      when(
        () => mockSurveyRepository.getSurveyList(
          pageNumber: 1,
          pageSize: AppConstants.defaultPageSize,
          isForceReload: false,
        ),
      ).thenAnswer((_) async => Success([MockUtil.mockSurveyModel]));

      await container.read(surveyListViewModelProvider.notifier).initialLoad();

      // Then
      final updatedState = container.read(surveyListViewModelProvider);

      expect(updatedState.surveyList, [MockUtil.mockSurveyModel]);
    },
  );

  test(
    'When calling refresh, it force reload the survey list and reset pageNumber and index',
    () async {
      // Given
      final expectedInitialState = SurveyListUiModel(
        surveyList: List.empty(),
        currentIndex: 0,
        isLoading: true,
        hasMore: true,
        isFirstLoad: true,
      );

      // When
      final surveyListUiModel = container.read(surveyListViewModelProvider);

      expect(surveyListUiModel, expectedInitialState);

      when(
        () => mockSurveyRepository.getSurveyList(
          pageNumber: any(named: 'pageNumber'),
          pageSize: AppConstants.defaultPageSize,
          isForceReload: any(named: 'isForceReload'),
        ),
      ).thenAnswer((_) async => Success([MockUtil.mockSurveyModel]));

      await container.read(surveyListViewModelProvider.notifier).initialLoad();
      await container.read(surveyListViewModelProvider.notifier).loadMore();

      final loadMoreState = container.read(surveyListViewModelProvider);

      expect(loadMoreState.surveyList, [
        MockUtil.mockSurveyModel,
        MockUtil.mockSurveyModel,
      ]);

      await container.read(surveyListViewModelProvider.notifier).refresh();

      // Then
      final refreshState = container.read(surveyListViewModelProvider);

      expect(refreshState.surveyList, [MockUtil.mockSurveyModel]);
    },
  );

  test(
    'When calling loadMore, it fetch subsequent page of the survey list and update SurveyListUiModel',
    () async {
      // Given
      final expectedInitialState = SurveyListUiModel(
        surveyList: List.empty(),
        currentIndex: 0,
        isLoading: true,
        hasMore: true,
        isFirstLoad: true,
      );

      // When
      final surveyListUiModel = container.read(surveyListViewModelProvider);

      expect(surveyListUiModel, expectedInitialState);

      when(
        () => mockSurveyRepository.getSurveyList(
          pageNumber: any(named: 'pageNumber'),
          pageSize: AppConstants.defaultPageSize,
          isForceReload: false,
        ),
      ).thenAnswer((_) async => Success([MockUtil.mockSurveyModel]));

      await container.read(surveyListViewModelProvider.notifier).initialLoad();
      await container.read(surveyListViewModelProvider.notifier).loadMore();

      // Then
      final updatedState = container.read(surveyListViewModelProvider);

      expect(updatedState.surveyList, [
        MockUtil.mockSurveyModel,
        MockUtil.mockSurveyModel,
      ]);
    },
  );
}
