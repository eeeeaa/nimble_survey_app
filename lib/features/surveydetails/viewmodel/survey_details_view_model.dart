import 'package:nimble_survey_app/core/model/survey_details_model.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/model/survey_details_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/provider/repository_provider.dart';
import '../../../../core/utils/error_wrapper.dart';
import '../../../core/model/submit_survey_request.dart';

part 'survey_details_view_model.g.dart';

@riverpod
class SurveyDetailsViewModel extends _$SurveyDetailsViewModel {
  late final SurveyDetailsRepository _surveyDetailsRepository = ref.watch(
    surveyDetailsRepositoryProvider,
  );

  @override
  SurveyDetailsUiModel build() => SurveyDetailsUiModel(surveyDetails: null);

  Future<void> initialLoad({required String id}) async {
    if (!ref.mounted) return;

    state = state.copyWith(isLoading: true);
    final survey = await _getSurveyDetails(id: id);

    state = state.copyWith(surveyDetails: survey, isLoading: false);
  }

  Future<SurveyDetailsModel?> _getSurveyDetails({required String id}) async {
    final result = await _surveyDetailsRepository.getSurveyDetails(id);
    return result is Success ? (result as Success).data : null;
  }

  void updateSurveyQuestion({
    required String questionId,
    required List<AnswerUiModel> answers,
    required bool shouldHaveAnswerText,
  }) {
    final updatedQuestions = Map<String, List<AnswerUiModel>>.from(
      state.surveyQuestions,
    );
    updatedQuestions[questionId] =
        shouldHaveAnswerText
            ? answers
            : answers.map((item) => item.copyWith(answer: null)).toList();
    state = state.copyWith(surveyQuestions: updatedQuestions);
  }

  void clearSurveyQuestion() {
    state = state.copyWith(surveyQuestions: {});
  }

  void submitSurvey() {
    final surveyId = state.surveyDetails?.id;
    if (surveyId == null || surveyId.isEmpty) return;

    List<SubmitSurveyQuestionItem> questionItems = [];

    state.surveyQuestions.forEach((questionId, answers) {
      final answerItems =
          answers
              .map(
                (item) => SubmitSurveyAnswerItem(
                  id: item.itemId,
                  answer: item.answer,
                ),
              )
              .toList();

      questionItems.add(
        SubmitSurveyQuestionItem(id: questionId, answers: answerItems),
      );
    });

    final request = SubmitSurveyRequest(
      surveyId: surveyId,
      questions: questionItems,
    );
    _surveyDetailsRepository.submitSurvey(request);
  }
}
