import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_survey_app/core/local/database.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/model/user_model.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository_impl.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

void main() {
  late AppDatabase database;
  late LocalStorageRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = LocalStorageRepositoryImpl(database: database);
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'When calling getCachedUserProfile successfully, it returns success response',
    () async {
      // Given
      final user = UserModel(
        id: 'id',
        email: 'email',
        name: 'john',
        avatar: 'url',
      );

      // When
      await repository.updateCachedUserProfile(user);
      final result = await repository.getCachedUserProfile();

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, user);
    },
  );

  test(
    'When calling getCachedUserProfile without existing data, it returns null user model',
    () async {
      // When
      final result = await repository.getCachedUserProfile();

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, null);
    },
  );

  test(
    'When calling clearCachedUserProfile, it clears user profile cache',
    () async {
      // Given
      final user = UserModel(
        id: 'id',
        email: 'email',
        name: 'john',
        avatar: 'url',
      );

      // When
      await repository.updateCachedUserProfile(user);
      final result = await repository.getCachedUserProfile();

      expect(result, isA<Success>());
      expect((result as Success).data, user);

      // Then
      final cleared = await repository.clearCachedUserProfile();
      final resultAfterCleared = await repository.getCachedUserProfile();

      expect(cleared, isA<Success>());
      expect(resultAfterCleared, isA<Success>());
      expect((resultAfterCleared as Success).data, null);
    },
  );

  test(
    'When calling getCachedSurveyModelList successfully, it returns success response',
    () async {
      // Given
      final surveyList = [
        SurveyModel(
          id: 'id',
          title: 'title',
          description: 'description',
          coverImageUrl: 'url',
        ),
      ];

      // When
      await repository.updateCachedSurveyModelList(surveyList);
      final result = await repository.getCachedSurveyModelList();

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, surveyList);
    },
  );

  test(
    'When calling getCachedSurveyModelList without existing data, it returns empty list',
    () async {
      // When
      final result = await repository.getCachedSurveyModelList();

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, []);
    },
  );

  test(
    'When calling clearCachedSurveyModelList, it clears survey list cache',
    () async {
      // Given
      final surveyList = [
        SurveyModel(
          id: 'id',
          title: 'title',
          description: 'description',
          coverImageUrl: 'url',
        ),
      ];

      // When
      await repository.updateCachedSurveyModelList(surveyList);
      final result = await repository.getCachedSurveyModelList();

      expect(result, isA<Success>());
      expect((result as Success).data, surveyList);

      // Then
      final cleared = await repository.clearCachedSurveyModelList();
      final resultAfterCleared = await repository.getCachedSurveyModelList();

      expect(cleared, isA<Success>());
      expect(resultAfterCleared, isA<Success>());
      expect((resultAfterCleared as Success).data, []);
    },
  );

  test('When calling clearAll, it clears all cache', () async {
    // Given
    final user = UserModel(
      id: 'id',
      email: 'email',
      name: 'john',
      avatar: 'url',
    );

    final surveyList = [
      SurveyModel(
        id: 'id',
        title: 'title',
        description: 'description',
        coverImageUrl: 'url',
      ),
    ];

    // When
    await repository.updateCachedUserProfile(user);
    await repository.updateCachedSurveyModelList(surveyList);
    final resultSurvey = await repository.getCachedSurveyModelList();
    final resultUser = await repository.getCachedUserProfile();

    expect(resultSurvey, isA<Success>());
    expect((resultSurvey as Success).data, surveyList);
    expect(resultUser, isA<Success>());
    expect((resultUser as Success).data, user);

    // Then
    final cleared = await repository.clearAll();
    final resultSurveyAfterCleared =
        await repository.getCachedSurveyModelList();
    final resultUserAfterCleared = await repository.getCachedUserProfile();

    expect(cleared, isA<Success>());
    expect(resultSurveyAfterCleared, isA<Success>());
    expect((resultSurveyAfterCleared as Success).data, []);
    expect(resultUserAfterCleared, isA<Success>());
    expect((resultUserAfterCleared as Success).data, null);
  });
}
