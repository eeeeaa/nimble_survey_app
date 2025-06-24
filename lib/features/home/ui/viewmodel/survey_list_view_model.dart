import 'package:nimble_survey_app/features/home/model/survey_list_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/model/survey_response.dart';
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
  final int _pageSize = 5;

  @override
  SurveyListUiModel build() => SurveyListUiModel(
    surveyList: List.empty(),
    isLoading: true,
    hasMore: true,
  );

  Future<void> initialLoad() async {
    state = state.copyWith(isLoading: true);
    final SurveyResponse? res = await _getSurveyList(1);
    _currentPage++;

    state = state.copyWith(
      surveyList: res?.data ?? List.empty(),
      isLoading: false,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading == true || state.hasMore == false) return;

    state = state.copyWith(isLoading: true);
    final SurveyResponse? res = await _getSurveyList(_currentPage);
    final surveyList = res?.data;

    if (surveyList?.isEmpty == true || surveyList == null) {
      state = state.copyWith(isLoading: false, hasMore: false);
    } else {
      final updatedList = [...state.surveyList, ...surveyList];
      state = state.copyWith(
        surveyList: updatedList,
        isLoading: false,
        hasMore: true,
      );
      _currentPage++;
    }
  }

  Future<SurveyResponse?> _getSurveyList(int pageNumber) async {
    final result = await _surveyRepository.getSurveyList(
      pageNumber: pageNumber,
      pageSize: _pageSize,
    );
    return result is Success ? (result as Success).data : null;
  }
}
