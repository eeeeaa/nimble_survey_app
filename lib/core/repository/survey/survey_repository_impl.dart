import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../network/service/survey_service.dart';

class SurveyRepositoryImpl extends SurveyRepository {
  final LocalStorageRepository localStorageRepository;
  final SurveyService surveyService;

  SurveyRepositoryImpl({
    required this.surveyService,
    required this.localStorageRepository,
  });

  @override
  Future<Result<List<SurveyModel>>> getSurveyList({
    required int pageNumber,
    required int pageSize,
    required bool isForceReload,
  }) async {
    if (isForceReload) {
      return _getRemoteSurveyList(pageNumber: pageNumber, pageSize: pageSize);
    }

    final cachedResult =
        await localStorageRepository.getCachedSurveyModelList();

    if (cachedResult is Success<List<SurveyModel>>) {
      final data =
          cachedResult.data
              .skip((pageNumber - 1) * pageSize)
              .take(pageSize)
              .toList();

      if (data.isNotEmpty) {
        return Success<List<SurveyModel>>(data);
      }
    }

    // Fallback to remote if cache is empty or failed
    return _getRemoteSurveyList(pageNumber: pageNumber, pageSize: pageSize);
  }

  Future<Result<List<SurveyModel>>> _getRemoteSurveyList({
    required int pageNumber,
    required int pageSize,
  }) {
    return safeApiCall<SurveyResponse, List<SurveyModel>>(
      call: () => surveyService.getSurveyList(pageNumber, pageSize),
      mapper: (res) async {
        final list =
            res.data
                ?.map((surveyData) => SurveyModel.fromResponse(res: surveyData))
                .toList() ??
            List.empty();
        await localStorageRepository.clearCachedSurveyModelList();
        await localStorageRepository.updateCachedSurveyModelList(list);
        return list;
      },
    );
  }
}
