import 'package:flutter/cupertino.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_text_area.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/base_answer.dart';

import '../../../../../../core/ui/theme/app_dimension.dart';
import '../../../../../../l10n/app_localizations.dart';

class AnswerTextArea extends BaseAnswer {
  const AnswerTextArea({
    super.key,
    required super.answers,
    required super.onUpdateAnswer,
  });

  @override
  BaseAnswerState<AnswerTextArea> createState() => _AnswerTextAreaState();
}

class _AnswerTextAreaState extends BaseAnswerState<AnswerTextArea> {
  List<AnswerUiModel> answerList = [];

  @override
  Widget buildAnswer(BuildContext context) {
    return Column(
      spacing: AppDimension.spacingSmall,
      children: List.generate(widget.answers.length, (index) {
        return NimbleTextArea(
          hintText:
              widget.answers[index].answer ??
              AppLocalizations.of(context)?.textAreaAnswerHint ??
              '',
          onChanged: (text) {
            // TODO submit the answer on button click
          },
        );
      }),
    );
  }
}
