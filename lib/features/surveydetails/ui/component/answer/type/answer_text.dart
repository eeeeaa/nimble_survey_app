import 'package:flutter/cupertino.dart';

import '../../../../../../core/ui/component/nimble_text_area.dart';
import '../../../../../../core/ui/component/nimble_text_field.dart';
import '../../../../../../core/ui/theme/app_dimension.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../model/answer_ui_model.dart';
import '../base_answer.dart';

class AnswerText extends BaseAnswer {
  final bool isTextArea;

  const AnswerText({
    super.key,
    required this.isTextArea,
    required super.answers,
    required super.onUpdateAnswer,
  });

  @override
  BaseAnswerState<AnswerText> createState() => _AnswerTextState();
}

class _AnswerTextState extends BaseAnswerState<AnswerText> {
  Map<String, String> answerMap = {};

  void mapAnswerAndSubmit() {
    List<AnswerUiModel> answers = [];

    answerMap.forEach((itemId, answer) {
      answers.add(AnswerUiModel(itemId: itemId, answer: answer));
    });

    submitAnswer(answers);
  }

  Widget _createTextField(int index) {
    return NimbleTextField(
      hintText: widget.answers[index].answer ?? '',
      onChanged: (text) {
        final currentAnswer = widget.answers[index];
        setState(() {
          answerMap[currentAnswer.itemId] = text;
        });
        mapAnswerAndSubmit();
      },
    );
  }

  Widget _createTextArea(int index) {
    return NimbleTextArea(
      hintText:
          widget.answers[index].answer ??
          AppLocalizations.of(context)?.textAreaAnswerHint ??
          '',
      onChanged: (text) {
        final currentAnswer = widget.answers[index];
        setState(() {
          answerMap[currentAnswer.itemId] = text;
        });
        mapAnswerAndSubmit();
      },
    );
  }

  @override
  Widget buildAnswer(BuildContext context) {
    return Column(
      spacing: AppDimension.spacingSmall,
      children: List.generate(widget.answers.length, (index) {
        return widget.isTextArea
            ? _createTextArea(index)
            : _createTextField(index);
      }),
    );
  }
}
