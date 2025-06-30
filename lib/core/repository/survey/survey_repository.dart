import 'package:nimble_survey_app/core/model/survey_response.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

abstract class SurveyRepository {
  Future<Result<SurveyResponse>> getSurveyList({
    required int pageNumber,
    required int pageSize,
  });
}
