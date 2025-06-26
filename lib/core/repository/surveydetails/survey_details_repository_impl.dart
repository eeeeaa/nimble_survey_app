import 'package:nimble_survey_app/core/model/survey_details_model.dart';
import 'package:nimble_survey_app/core/model/survey_details_response.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../network/service/survey_service.dart';

class SurveyDetailsRepositoryImpl extends SurveyDetailsRepository {
  final SurveyService surveyService;

  SurveyDetailsRepositoryImpl({required this.surveyService});

  @override
  Future<Result<SurveyDetailsModel>> getSurveyDetails(String surveyId) async {
    return safeApiCall<SurveyDetailsResponse, SurveyDetailsModel>(
      call: () => surveyService.getSurveyDetails(surveyId),
      mapper: (res) => SurveyDetailsModel.fromResponse(res: res),
    );
  }
}
