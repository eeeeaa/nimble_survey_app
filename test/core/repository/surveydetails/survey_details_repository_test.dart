import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/model/survey_details_model.dart';
import 'package:nimble_survey_app/core/network/service/survey_service.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository_impl.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../../mocks/mock_util.dart';
import '../../../mocks/mocks.dart';

void main() {
  late SurveyService mockSurveyService;

  late SurveyDetailsRepository repository;

  setUp(() {
    mockSurveyService = MockSurveyService();

    repository = SurveyDetailsRepositoryImpl(surveyService: mockSurveyService);
  });

  test(
    'When calling getSurveyDetails successfully, it returns successful response',
    () async {
      // Given
      final surveyId = "surveyId";

      // When
      when(
        () => mockSurveyService.getSurveyDetails(surveyId),
      ).thenAnswer((_) async => MockUtil.mockSurveyDetailsResponse);

      final result = await repository.getSurveyDetails(surveyId);

      // Then
      expect(result, isA<Success>());
      expect(
        (result as Success).data,
        SurveyDetailsModel(
          id: '',
          title: '',
          description: '',
          coverImageUrl: '',
          questions: [],
        ),
      );

      verify(() => mockSurveyService.getSurveyDetails(surveyId)).called(1);
    },
  );
  test(
    'When calling getSurveyDetails failed, it returns wrapped error',
    () async {
      // Given
      final surveyId = "surveyId";

      // When
      when(
        () => mockSurveyService.getSurveyDetails(surveyId),
      ).thenThrow(Exception());

      final result = await repository.getSurveyDetails(surveyId);

      // Then
      expect(result, isA<Failure>());

      verify(() => mockSurveyService.getSurveyDetails(surveyId)).called(1);
    },
  );

  test(
    'When submitting survey successful, it returns successful response',
    () async {
      // When
      when(
        () => mockSurveyService.submitSurvey(MockUtil.mockSubmitSurveyRequest),
      ).thenAnswer((_) async => {});

      final result = await repository.submitSurvey(
        MockUtil.mockSubmitSurveyRequest,
      );

      // Then
      expect(result, isA<Success>());

      verify(
        () => mockSurveyService.submitSurvey(MockUtil.mockSubmitSurveyRequest),
      ).called(1);
    },
  );

  test('When submitting survey failed, it returns wrapped error', () async {
    // When
    when(
      () => mockSurveyService.submitSurvey(MockUtil.mockSubmitSurveyRequest),
    ).thenThrow(Exception());

    final result = await repository.submitSurvey(
      MockUtil.mockSubmitSurveyRequest,
    );

    // Then
    expect(result, isA<Failure>());

    verify(
      () => mockSurveyService.submitSurvey(MockUtil.mockSubmitSurveyRequest),
    ).called(1);
  });
}
