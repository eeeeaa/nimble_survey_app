import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/display_type.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_checkbox.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_single_choice.dart';

class AnswerItem extends ConsumerWidget {
  final List<AnswerUiModel> answers;
  final DisplayType displayType;
  final PickType pickType;

  const AnswerItem({
    required this.answers,
    required this.displayType,
    required this.pickType,
    super.key,
  });

  _onUpdateAnswer(answerId) {
    // TODO handle answer id
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (displayType) {
      case DisplayType.intro:
        return Container();
      case DisplayType.outro:
        return Container();
      case DisplayType.choice:
        if (pickType == PickType.any) {
          return AnswerCheckbox(
            onUpdateAnswer: _onUpdateAnswer,
            answers: answers,
          );
        } else {
          return AnswerSingleChoice(
            onUpdateAnswer: _onUpdateAnswer,
            answers: answers,
          );
        }
      default:
        return AnswerSingleChoice(
          onUpdateAnswer: _onUpdateAnswer,
          answers: answers,
        );
    }
  }
}
