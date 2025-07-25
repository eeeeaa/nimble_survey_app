import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_answer_model.freezed.dart';

@freezed
abstract class SurveyAnswerModel with _$SurveyAnswerModel {
  const factory SurveyAnswerModel({
    required String id,
    required String? answerText,
    required int displayOrder, // The order for the answer
  }) = _SurveyAnswerModel;
}
