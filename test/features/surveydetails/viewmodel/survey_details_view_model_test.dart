import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/model/survey_details_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/viewmodel/survey_details_view_model.dart';

import '../../../mocks/mock_util.dart';
import '../../../mocks/mocks.dart';

void main() {
  late SurveyDetailsRepository mockSurveyDetailsRepository;

  late ProviderContainer container;

  setUp(() {
    mockSurveyDetailsRepository = MockSurveyDetailsRepository();

    registerFallbackValue(MockUtil.mockSubmitSurveyRequest);

    container = ProviderContainer(
      overrides: [
        surveyDetailsRepositoryProvider.overrideWithValue(
          mockSurveyDetailsRepository,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'When view model initialize, it returns initial SurveyDetailsUiModel',
    () {
      // Given
      final expected = SurveyDetailsUiModel(surveyDetails: null);

      // When
      final surveyDetailsUiModel = container.read(
        surveyDetailsViewModelProvider,
      );

      // Then
      expect(surveyDetailsUiModel, expected);
    },
  );

  test('When calling initial load, it returns SurveyDetailsUiModel', () async {
    // Given
    final expected = SurveyDetailsUiModel(
      surveyDetails: MockUtil.mockSurveyDetailsModel,
    );
    final surveyId = 'id';

    // When
    when(
      () => mockSurveyDetailsRepository.getSurveyDetails(any()),
    ).thenAnswer((_) async => Success(MockUtil.mockSurveyDetailsModel));

    await container
        .read(surveyDetailsViewModelProvider.notifier)
        .initialLoad(id: surveyId);

    final surveyDetailsUiModel = container.read(surveyDetailsViewModelProvider);

    // Then
    expect(surveyDetailsUiModel, expected);
    verify(
      () => mockSurveyDetailsRepository.getSurveyDetails(surveyId),
    ).called(1);
  });

  test(
    'When calling updateSurveyQuestion, it updates the survey questions in SurveyDetailsUiModel',
    () {
      // Given
      final answers = [AnswerUiModel(itemId: 'itemId', answer: 'answer')];
      final questionId = 'questionId';

      // When
      container
          .read(surveyDetailsViewModelProvider.notifier)
          .updateSurveyQuestion(
            questionId: questionId,
            answers: answers,
            shouldHaveAnswerText: true,
          );

      final updatedState = container.read(surveyDetailsViewModelProvider);

      // Then
      expect(updatedState.surveyQuestions[questionId], answers);
    },
  );

  test(
    'When calling clearSurveyQuestion, it clears the survey questions in SurveyDetailsUiModel',
    () {
      // Given
      final answers = [AnswerUiModel(itemId: 'itemId', answer: 'answer')];
      final questionId = 'questionId';

      // When
      container
          .read(surveyDetailsViewModelProvider.notifier)
          .updateSurveyQuestion(
            questionId: questionId,
            answers: answers,
            shouldHaveAnswerText: true,
          );

      final initialState = container.read(surveyDetailsViewModelProvider);
      expect(initialState.surveyQuestions[questionId], answers);

      container
          .read(surveyDetailsViewModelProvider.notifier)
          .clearSurveyQuestion();

      // Then
      final updatedState = container.read(surveyDetailsViewModelProvider);
      expect(updatedState.surveyQuestions.isEmpty, true);
    },
  );

  test(
    'When calling submitSurvey, it submit the survey questions via the repository',
    () async {
      //Given
      final surveyId = 'id';

      // When
      when(
        () => mockSurveyDetailsRepository.getSurveyDetails(any()),
      ).thenAnswer((_) async => Success(MockUtil.mockSurveyDetailsModel));
      when(
        () => mockSurveyDetailsRepository.submitSurvey(any()),
      ).thenAnswer((_) async => Success(null));

      await container
          .read(surveyDetailsViewModelProvider.notifier)
          .initialLoad(id: surveyId);

      final result =
          await container
              .read(surveyDetailsViewModelProvider.notifier)
              .submitSurvey();

      expect(result, isA<Success>());
      verify(() => mockSurveyDetailsRepository.submitSurvey(any())).called(1);
    },
  );
}
