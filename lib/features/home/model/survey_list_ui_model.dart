import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/model/survey_response.dart';

part 'survey_list_ui_model.freezed.dart';

@freezed
abstract class SurveyListUiModel with _$SurveyListUiModel {
  const factory SurveyListUiModel({
    required List<SurveyData> surveyList,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
  }) = _SurveyListUiModel;
}
