import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/model/survey_details_model.dart';

part 'survey_details_ui_model.freezed.dart';

@freezed
abstract class SurveyDetailsUiModel with _$SurveyDetailsUiModel {
  const factory SurveyDetailsUiModel({
    required SurveyDetailsModel? surveyDetails,
    @Default(false) bool isLoading,
  }) = _SurveyDetailsUiModel;
}
