import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';

part 'survey_model.freezed.dart';

@freezed
abstract class SurveyModel with _$SurveyModel {
  const factory SurveyModel({
    required String id,
    required String title,
    required String description,
    required String coverImageUrl,
  }) = _SurveyModel;

  factory SurveyModel.fromResponse({required SurveyData res}) => SurveyModel(
    id: res.id ?? '',
    title: res.attributes?.title ?? '',
    description: res.attributes?.description ?? '',
    coverImageUrl: res.attributes?.coverImageUrl ?? '',
  );
}
