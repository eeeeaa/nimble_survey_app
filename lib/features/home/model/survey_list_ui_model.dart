import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';

part 'survey_list_ui_model.freezed.dart';

@freezed
abstract class SurveyListUiModel with _$SurveyListUiModel {
  const factory SurveyListUiModel({
    required List<SurveyModel> surveyList,
    required int currentIndex,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default(true) bool isFirstLoad,
  }) = _SurveyListUiModel;
}
