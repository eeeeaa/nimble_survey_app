import 'package:nimble_survey_app/core/model/survey_response.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../network/service/survey_service.dart';

class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyService surveyService;

  SurveyRepositoryImpl({required this.surveyService});

  @override
  Future<Result<SurveyResponse>> getSurveyList({
    required int pageNumber,
    required int pageSize,
  }) async {
    return safeApiCall(
      call: () => surveyService.getSurveyList(pageNumber, pageSize),
    );
  }
}
