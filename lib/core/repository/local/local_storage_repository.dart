import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/model/user_model.dart';

import '../../utils/error_wrapper.dart';

abstract class LocalStorageRepository {
  Future<Result<UserModel?>> getCachedUserProfile();

  Future<Result<void>> updateCachedUserProfile(UserModel model);

  Future<Result<void>> clearCachedUserProfile();

  Future<Result<List<SurveyModel>>> getCachedSurveyModelList();

  Future<Result<void>> updateCachedSurveyModelList(
    List<SurveyModel> surveyList,
  );

  Future<Result<void>> clearCachedSurveyModelList();

  Future<Result<void>> clearAll();
}
