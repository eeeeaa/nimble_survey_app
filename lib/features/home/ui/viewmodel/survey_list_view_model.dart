import 'package:nimble_survey_app/core/constants/app_constants.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/features/home/model/survey_list_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/provider/repository_provider.dart';
import '../../../../core/repository/survey/survey_repository.dart';
import '../../../../core/utils/error_wrapper.dart';

part 'survey_list_view_model.g.dart';

@riverpod
class SurveyListViewModel extends _$SurveyListViewModel {
  late final SurveyRepository _surveyRepository = ref.watch(
    surveyRepositoryProvider,
  );
  int _currentPage = 1;

  @override
  SurveyListUiModel build() => SurveyListUiModel(
    surveyList: List.empty(),
    currentIndex: 0,
    isLoading: true,
    hasMore: true,
    isFirstLoad: true,
  );

  void updateCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  Future<void> initialLoad() async {
    if (!ref.mounted) return;

    state = state.copyWith(isLoading: true);
    final List<SurveyModel> surveyList = await _getSurveyList(
      pageNumber: _currentPage,
    );
    _currentPage++;

    state = state.copyWith(
      surveyList: surveyList,
      isLoading: false,
      isFirstLoad: false,
    );
  }

  Future<void> refresh() async {
    if (!ref.mounted) return;
    state = state.copyWith(isLoading: true);

    // Reload survey list
    final List<SurveyModel> surveyList = await _getSurveyList(
      pageNumber: 1,
      isForceReload: true,
      shouldClearCache: true,
    );
    if (surveyList.isNotEmpty) {
      _currentPage = 2; // Next page

      state = state.copyWith(
        surveyList: surveyList,
        currentIndex: 0,
        isLoading: false,
        isFirstLoad: false,
        isRefreshSuccess: true,
      );
    } else {
      state = state.copyWith(isLoading: false, isRefreshSuccess: false);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading == true || state.hasMore == false || !ref.mounted) {
      return;
    }

    state = state.copyWith(isLoading: true);
    final List<SurveyModel> surveyList = await _getSurveyList(
      pageNumber: _currentPage,
    );

    if (surveyList.isNotEmpty) {
      final updatedList = [...state.surveyList, ...surveyList];
      state = state.copyWith(
        surveyList: updatedList,
        isLoading: false,
        hasMore: true,
      );
      _currentPage++;
    } else {
      state = state.copyWith(isLoading: false, hasMore: false);
    }
  }

  Future<List<SurveyModel>> _getSurveyList({
    required int pageNumber,
    bool isForceReload = false,
    bool shouldClearCache = false,
  }) async {
    final result = await _surveyRepository.getSurveyList(
      pageNumber: pageNumber,
      pageSize: AppConstants.defaultPageSize,
      isForceReload: isForceReload,
      shouldClearCache: shouldClearCache,
    );
    return result is Success ? (result as Success).data : List.empty();
  }
}
