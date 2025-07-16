import 'package:flutter/material.dart';

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

  @override
  Widget buildAnswer(BuildContext context) {
    final answers = widget.answers;

    return Center(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: answers.length,
        separatorBuilder: (context, index) {
          if (index == answers.length - 2) {
            return Container();
          }
          return Divider(color: Colors.white);
        },
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              answers[index].answerText,
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
                  selectedIndices.add(index);
                } else {
                  selectedIndices.remove(index);
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
