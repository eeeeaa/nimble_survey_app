import 'package:flutter/material.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';

import '../../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../../gen/colors.gen.dart';
import '../base_answer.dart';

class AnswerDropDown extends BaseAnswer {
  const AnswerDropDown({
    super.key,
    required super.onUpdateAnswer,
    required super.answers,
  });

  @override
  BaseAnswerState<AnswerDropDown> createState() => _AnswerDropDown();
}

class _AnswerDropDown extends BaseAnswerState<AnswerDropDown> {
  AnswerUiModel? selectedAnswer;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedAnswer = widget.answers.first;
    });
    submitAnswer([widget.answers.first]);
  }

  @override
  Widget buildAnswer(BuildContext context) {
    final answerList =
        widget.answers.map((item) {
          return DropdownMenuEntry<AnswerUiModel>(
            value: item,
            label: item.answer ?? '',
          );
        }).toList();

    return Center(
      child: DropdownMenu<AnswerUiModel>(
        initialSelection: widget.answers.first,
        dropdownMenuEntries: answerList,
        textStyle: TextStyle(
          color: ColorName.primaryText,
          fontSize: AppTextSize.textSizeLarge,
          fontWeight: FontWeight.normal,
        ),
        onSelected: (AnswerUiModel? answer) {
          setState(() {
            selectedAnswer = answer;
          });
          if (answer != null) {
            submitAnswer([answer]);
          }
        },
      ),
    );
  }
}
