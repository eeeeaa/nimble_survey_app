import 'package:nimble_survey_app/core/model/submit_survey_request.dart';
import 'package:nimble_survey_app/core/model/survey_details_model.dart';

import '../../utils/error_wrapper.dart';

abstract class SurveyDetailsRepository {
  Future<Result<SurveyDetailsModel>> getSurveyDetails(String surveyId);

  Future<Result<void>> submitSurvey(SubmitSurveyRequest request);
}
