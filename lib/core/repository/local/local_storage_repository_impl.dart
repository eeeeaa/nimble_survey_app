import 'package:nimble_survey_app/core/local/database.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/model/user_model.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final AppDatabase database;

  LocalStorageRepositoryImpl({required this.database});

  @override
  Future<Result<void>> clearAll() async {
    await clearCachedUserProfile();
    await clearCachedSurveyModelList();
    return Success(null);
  }

  @override
  Future<Result<void>> clearCachedUserProfile() async {
    return safeApiCall(
      call: () => database.delete(database.userProfileTable).go(),
    );
  }

  @override
  Future<Result<UserModel?>> getCachedUserProfile() async {
    return safeApiCall<UserProfileTableData?, UserModel?>(
      call: () => database.select(database.userProfileTable).getSingleOrNull(),
      mapper:
          (row) =>
              row != null
                  ? UserModel(
                    id: row.id,
                    email: row.email,
                    name: row.name,
                    avatar: row.avatar,
                  )
                  : null,
    );
  }

  @override
  Future<Result<void>> updateCachedUserProfile(UserModel model) async {
    return safeApiCall(
      call:
          () => database
              .into(database.userProfileTable)
              .insertOnConflictUpdate(
                UserProfileTableCompanion.insert(
                  id: model.id,
                  email: model.email,
                  name: model.name,
                  avatar: model.avatar,
                ),
              ),
    );
  }

  @override
  Future<Result<void>> clearCachedSurveyModelList() async {
    return safeApiCall(
      call: () => database.delete(database.surveyListTable).go(),
    );
  }

  @override
  Future<Result<List<SurveyModel>>> getCachedSurveyModelList() async {
    return safeApiCall<List<SurveyListTableData>, List<SurveyModel>>(
      call: () => database.select(database.surveyListTable).get(),
      mapper:
          (rows) =>
              rows
                  .map(
                    (row) => SurveyModel(
                      id: row.id,
                      title: row.title,
                      description: row.description,
                      coverImageUrl: row.coverImageUrl,
                    ),
                  )
                  .toList(),
    );
  }

  @override
  Future<Result<void>> updateCachedSurveyModelList(
    List<SurveyModel> surveyList,
  ) async {
    return safeApiCall(
      call:
          () => database.batch((batch) {
            batch.insertAllOnConflictUpdate(
              database.surveyListTable,
              surveyList
                  .map(
                    (s) => SurveyListTableCompanion.insert(
                      id: s.id,
                      title: s.title,
                      description: s.description,
                      coverImageUrl: s.coverImageUrl,
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
