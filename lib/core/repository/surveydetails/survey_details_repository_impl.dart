import 'package:nimble_survey_app/core/model/survey_details_model.dart';
import 'package:nimble_survey_app/core/model/survey_details_response.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../network/service/survey_service.dart';

class SurveyDetailsRepositoryImpl extends SurveyDetailsRepository {
  final LocalStorageRepository localStorageRepository;
  final SurveyService surveyService;

  SurveyDetailsRepositoryImpl({
    required this.surveyService,
    required this.localStorageRepository,
  });

  @override
  Future<Result<SurveyDetailsModel>> getSurveyDetails(
    String surveyId,
    bool isForceReload,
  ) async {
    if (isForceReload) {
      return _getRemoteSurveyDetails(surveyId);
    }

    final cache = await localStorageRepository.getCachedSurveyDetailsModel(
      surveyId,
    );

    if (cache is Success<SurveyDetailsModel?>) {
      final data = cache.data;
      if (data != null) {
        return Success(data);
      }
    }

    return _getRemoteSurveyDetails(surveyId);
  }

  Future<Result<SurveyDetailsModel>> _getRemoteSurveyDetails(
    String surveyId,
  ) async {
    return safeApiCall<SurveyDetailsResponse, SurveyDetailsModel>(
      call: () => surveyService.getSurveyDetails(surveyId),
      mapper: (res) {
        final data = SurveyDetailsModel.fromResponse(res: res);
        localStorageRepository.addOrUpdateCachedSurveyDetailsModel(data);
        return data;
      },
    );
  }
}
