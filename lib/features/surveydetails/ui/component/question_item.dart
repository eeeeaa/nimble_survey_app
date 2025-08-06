import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/survey_question_model.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer_item.dart';
import 'package:nimble_survey_app/features/surveydetails/viewmodel/survey_details_view_model.dart';

import '../../../../core/ui/theme/app_text_size.dart';
import '../../../../gen/colors.gen.dart';

class QuestionItem extends ConsumerWidget {
  final SurveyQuestionModel question;

  const QuestionItem({required this.question, super.key});

  List<AnswerUiModel> _getAnswerUiModelList() {
    return question.answers
        .map((item) => AnswerUiModel(itemId: item.id, answer: item.answerText))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onUpdateAnswer(List<AnswerUiModel> answers) {
      ref
          .read(surveyDetailsViewModelProvider.notifier)
          .updateSurveyQuestion(questionId: question.id, answers: answers);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Text(
              question.questionText,
              style: TextStyle(
                color: ColorName.primaryText,
                fontSize: AppTextSize.textSizeXXL,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: AnswerItem(
            displayType: question.displayType,
            answers: _getAnswerUiModelList(),
            pickType: question.pickType,
            onUpdateAnswer: onUpdateAnswer,
          ),
        ),
      ],
    );
  }
}
