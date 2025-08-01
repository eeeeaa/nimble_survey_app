import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/survey_answer_model.dart';

import 'display_type.dart';

part 'survey_question_model.freezed.dart';

@freezed
abstract class SurveyQuestionModel with _$SurveyQuestionModel {
  const factory SurveyQuestionModel({
    required String id,
    required String questionText,
    required DisplayType displayType, // The display type of the list of answers
    required PickType pickType,
    required List<SurveyAnswerModel> answers,
  }) = _SurveyQuestionModel;
}
