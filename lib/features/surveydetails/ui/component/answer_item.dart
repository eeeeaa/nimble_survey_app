import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/display_type.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_checkbox.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_dropdown.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_nps.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_rating.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_single_choice.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/type/answer_smiley.dart';

import '../../../../gen/assets.gen.dart';
import 'answer/type/answer_text.dart';

/// Answer Item, populated by answer type
class AnswerItem extends ConsumerWidget {
  final List<AnswerUiModel> answers;
  final DisplayType displayType;
  final PickType pickType;
  final void Function(List<AnswerUiModel>) onUpdateAnswer;

  const AnswerItem({
    required this.answers,
    required this.displayType,
    required this.pickType,
    required this.onUpdateAnswer,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (displayType) {
      case DisplayType.intro:
        return SizedBox.shrink();
      case DisplayType.outro:
        return SizedBox.shrink();
      case DisplayType.choice:
        if (pickType == PickType.any) {
          return AnswerCheckbox(
            onUpdateAnswer: onUpdateAnswer,
            answers: answers,
          );
        } else {
          return AnswerSingleChoice(
            onUpdateAnswer: onUpdateAnswer,
            answers: answers,
          );
        }
      case DisplayType.nps:
        return AnswerNps(answers: answers, onUpdateAnswer: onUpdateAnswer);
      case DisplayType.dropdown:
        return AnswerDropDown(onUpdateAnswer: onUpdateAnswer, answers: answers);
      case DisplayType.star:
        return AnswerRating(
          iconActive: Assets.images.icStarActive.image(width: 28, height: 34),
          iconInActive: Assets.images.icStarInactive.image(
            width: 28,
            height: 34,
          ),
          answers: answers,
          onUpdateAnswer: onUpdateAnswer,
        );
      case DisplayType.heart:
        return AnswerRating(
          iconActive: Assets.images.icHeartActive.image(width: 28, height: 34),
          iconInActive: Assets.images.icHeartInactive.image(
            width: 28,
            height: 34,
          ),
          answers: answers,
          onUpdateAnswer: onUpdateAnswer,
        );
      case DisplayType.thumpsUp:
        return AnswerRating(
          iconActive: Assets.images.icThumbsupActive.image(
            width: 28,
            height: 34,
          ),
          iconInActive: Assets.images.icThumbsupInactive.image(
            width: 28,
            height: 34,
          ),
          answers: answers,
          onUpdateAnswer: onUpdateAnswer,
        );
      case DisplayType.smiley:
        return AnswerSmiley(answers: answers, onUpdateAnswer: onUpdateAnswer);
      case DisplayType.textField:
        return AnswerText(
          isTextArea: false,
          answers: answers,
          onUpdateAnswer: onUpdateAnswer,
        );
      case DisplayType.textarea:
        return AnswerText(
          isTextArea: true,
          answers: answers,
          onUpdateAnswer: onUpdateAnswer,
        );
      default:
        return AnswerSingleChoice(
          onUpdateAnswer: onUpdateAnswer,
          answers: answers,
        );
    }
  }
}
