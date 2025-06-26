import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/survey_details_response.dart';

part 'survey_details_model.freezed.dart';

// TODO handle question and answer list
@freezed
abstract class SurveyDetailsModel with _$SurveyDetailsModel {
  const factory SurveyDetailsModel({
    required String id,
    required String title,
    required String description,
    required String coverImageUrl,
  }) = _SurveyDetailsModel;

  factory SurveyDetailsModel.fromResponse({
    required SurveyDetailsResponse res,
  }) => SurveyDetailsModel(
    id: res.data?.id ?? '',
    title: res.data?.attributes?.title ?? '',
    description: res.data?.attributes?.description ?? '',
    coverImageUrl: res.data?.attributes?.coverImageUrl ?? '',
  );
}
