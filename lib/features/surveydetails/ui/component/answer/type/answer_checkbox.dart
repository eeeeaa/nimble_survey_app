import 'package:flutter/material.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';

import '../../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../../gen/colors.gen.dart';
import '../base_answer.dart';

class AnswerCheckbox extends BaseAnswer {
  const AnswerCheckbox({
    super.key,
    required super.onUpdateAnswer,
    required super.answers,
  });

  @override
  BaseAnswerState<AnswerCheckbox> createState() => _AnswerCheckbox();
}

class _AnswerCheckbox extends BaseAnswerState<AnswerCheckbox> {
  List<int> selectedIndices = [];
  List<AnswerUiModel> selectedAnswers = [];

  void _addAnswer({required int index, required AnswerUiModel answer}) {
    selectedIndices.add(index);
    selectedAnswers.add(answer);
  }

  void _removeAnswer({required int index, required AnswerUiModel answer}) {
    selectedIndices.remove(index);
    selectedAnswers.remove(answer);
  }

  @override
  Widget buildAnswer(BuildContext context) {
    final answers = widget.answers;

    return Center(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: answers.length,
        separatorBuilder: (context, index) {
          if (index == answers.length - 1) {
            return Container();
          }
          return Divider(color: Colors.white);
        },
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              answers[index].answer ?? '',
              style: TextStyle(
                color: ColorName.primaryText,
                fontSize: AppTextSize.textSizeMedium,
              ),
            ),
            checkboxShape: CircleBorder(),
            checkColor: Colors.black,
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.transparent;
            }),
            side: const BorderSide(color: Colors.white),
            onChanged: (isSelected) {
              setState(() {
                if (isSelected == true) {
                  _addAnswer(index: index, answer: answers[index]);
                } else {
                  _removeAnswer(index: index, answer: answers[index]);
                }
              });
            },
            value: selectedIndices.contains(index),
          );
        },
      ),
    );
  }
}
