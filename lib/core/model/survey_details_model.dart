import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/survey_details_response.dart';
import 'package:nimble_survey_app/core/model/survey_question_model.dart';
import 'package:nimble_survey_app/core/utils/survey_question_mapper.dart';

part 'survey_details_model.freezed.dart';

@freezed
abstract class SurveyDetailsModel with _$SurveyDetailsModel {
  const factory SurveyDetailsModel({
    required String id,
    required String title,
    required String description,
    required String coverImageUrl,
    required List<SurveyQuestionModel> questions,
  }) = _SurveyDetailsModel;

  factory SurveyDetailsModel.fromResponse({
    required SurveyDetailsResponse res,
  }) => SurveyDetailsModel(
    id: res.data?.id ?? '',
    title: res.data?.attributes?.title ?? '',
    description: res.data?.attributes?.description ?? '',
    coverImageUrl: res.data?.attributes?.coverImageUrl ?? '',
    questions: mapToQuestionModelList(res: res),
  );
}
