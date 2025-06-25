import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../model/survey_model.dart';

abstract class SurveyRepository {
  Future<Result<List<SurveyModel>>> getSurveyList({
    required int pageNumber,
    required int pageSize,
  });
}
