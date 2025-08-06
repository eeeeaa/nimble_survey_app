import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_survey_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubmitSurveyRequest {
  final String surveyId;
  final List<SubmitSurveyQuestionItem> questions;

  SubmitSurveyRequest({required this.surveyId, required this.questions});

  factory SubmitSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyRequestToJson(this);
}

@JsonSerializable()
class SubmitSurveyQuestionItem {
  final String id;
  final List<SubmitSurveyAnswerItem> answers;

  SubmitSurveyQuestionItem({required this.id, required this.answers});

  factory SubmitSurveyQuestionItem.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyQuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyQuestionItemToJson(this);
}

@JsonSerializable()
class SubmitSurveyAnswerItem {
  final String id;
  final String? answer;

  SubmitSurveyAnswerItem({required this.id, required this.answer});

  factory SubmitSurveyAnswerItem.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyAnswerItemFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyAnswerItemToJson(this);
}
