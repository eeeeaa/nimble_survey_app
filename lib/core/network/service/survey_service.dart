import 'package:dio/dio.dart';
import 'package:nimble_survey_app/core/model/survey_details_response.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../model/submit_survey_request.dart';

part 'survey_service.g.dart';

@RestApi()
abstract class SurveyService {
  // Need to add logger due to: https://github.com/trevorwang/retrofit.dart/issues/745
  factory SurveyService(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _SurveyService;

  @GET('/surveys')
  Future<SurveyResponse> getSurveyList(
    @Query("page[number]") int pageNumber,
    @Query("page[size]") int pageSize,
  );

  @GET('/surveys/{id}')
  Future<SurveyDetailsResponse> getSurveyDetails(@Path('id') String surveyId);

  @POST("/responses")
  Future<void> submitSurvey(@Body() SubmitSurveyRequest body);
}
