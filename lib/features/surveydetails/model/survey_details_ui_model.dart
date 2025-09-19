import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';

import '../../../core/model/survey_details_model.dart';

part 'survey_details_ui_model.freezed.dart';

@freezed
abstract class SurveyDetailsUiModel with _$SurveyDetailsUiModel {
  const factory SurveyDetailsUiModel({
    required SurveyDetailsModel? surveyDetails,
    @Default({}) Map<String, List<AnswerUiModel>> surveyQuestions,
    @Default(false) bool isLoading,
    @Default(null) bool? isSurveySubmitted,
  }) = _SurveyDetailsUiModel;
}
