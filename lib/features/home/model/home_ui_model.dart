import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/features/home/model/user_entity.dart';

import '../../../core/model/survey_response.dart';

part 'home_ui_model.freezed.dart';

@freezed
abstract class HomeUiModel with _$HomeUiModel {
  const factory HomeUiModel({
    required UserEntity? user,
    required List<SurveyData> surveyList,
    @Default(false) bool isContentLoading,
    @Default(false) bool isLoggingOut,
  }) = _HomeUiModel;
}
