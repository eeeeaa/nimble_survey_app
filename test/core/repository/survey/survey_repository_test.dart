import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/network/service/survey_service.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository_impl.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../../mocks/mock_util.dart';
import '../../../mocks/mocks.dart';

void main() {
  late LocalStorageRepository mockLocalStorageRepository;
  late SurveyService mockSurveyService;

  late SurveyRepository repository;

  setUp(() {
    mockLocalStorageRepository = MockLocalStorageRepository();
    mockSurveyService = MockSurveyService();

    repository = SurveyRepositoryImpl(
      surveyService: mockSurveyService,
      localStorageRepository: mockLocalStorageRepository,
    );
  });

  test(
    'When calling getSurveyList successfully without cache, it fetch remote and returns successful response',
    () async {
      // Given
      final pageNumber = 1;
      final pageSize = 10;

      // When
      when(
        () => mockLocalStorageRepository.getCachedSurveyModelList(),
      ).thenAnswer((_) async => Success([]));
      when(
        () => mockLocalStorageRepository.updateCachedSurveyModelList(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockSurveyService.getSurveyList(any(), any()),
      ).thenAnswer((_) async => MockUtil.mockSurveyResponse);

      final result = await repository.getSurveyList(
        pageNumber: pageNumber,
        pageSize: pageSize,
        isForceReload: false,
      );

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, [MockUtil.mockSurveyModel]);

      verify(
        () => mockLocalStorageRepository.getCachedSurveyModelList(),
      ).called(1);
      verify(
        () => mockSurveyService.getSurveyList(pageNumber, pageSize),
      ).called(1);
    },
  );

  test(
    'When calling getSurveyList successfully with existing cache, it returns cache data',
    () async {
      // Given
      final pageNumber = 1;
      final pageSize = 10;

      // When
      when(
        () => mockLocalStorageRepository.getCachedSurveyModelList(),
      ).thenAnswer((_) async => Success([MockUtil.mockSurveyModel]));

      final result = await repository.getSurveyList(
        pageNumber: pageNumber,
        pageSize: pageSize,
        isForceReload: false,
      );

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, [MockUtil.mockSurveyModel]);

      verifyNever(() => mockSurveyService.getSurveyList(any(), any()));
    },
  );

  test(
    'When calling getSurveyList with isForceReload, it fetch remote even if cache exists',
    () async {
      // Given
      final pageNumber = 1;
      final pageSize = 10;

      // When
      when(
        () => mockLocalStorageRepository.getCachedSurveyModelList(),
      ).thenAnswer((_) async => Success([MockUtil.mockSurveyModel]));
      when(
        () => mockLocalStorageRepository.updateCachedSurveyModelList(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockSurveyService.getSurveyList(any(), any()),
      ).thenAnswer((_) async => MockUtil.mockSurveyResponse);

      final result = await repository.getSurveyList(
        pageNumber: pageNumber,
        pageSize: pageSize,
        isForceReload: true,
      );

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, [MockUtil.mockSurveyModel]);

      verifyNever(() => mockLocalStorageRepository.getCachedSurveyModelList());
      verify(
        () => mockSurveyService.getSurveyList(pageNumber, pageSize),
      ).called(1);
    },
  );

  test(
    'When calling remote getSurveyList failed, it returns warped error',
    () async {
      // Given
      final pageNumber = 1;
      final pageSize = 10;

      // When
      when(
        () => mockLocalStorageRepository.getCachedSurveyModelList(),
      ).thenAnswer((_) async => Success([]));
      when(
        () => mockLocalStorageRepository.updateCachedSurveyModelList(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockSurveyService.getSurveyList(any(), any()),
      ).thenThrow(Exception());

      final result = await repository.getSurveyList(
        pageNumber: pageNumber,
        pageSize: pageSize,
        isForceReload: false,
      );

      // Then
      expect(result, isA<Failure>());

      verify(
        () => mockLocalStorageRepository.getCachedSurveyModelList(),
      ).called(1);
      verify(
        () => mockSurveyService.getSurveyList(pageNumber, pageSize),
      ).called(1);
    },
  );
}
