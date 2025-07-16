import 'package:flutter/material.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/base_answer.dart';

import '../../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../../gen/colors.gen.dart';

class AnswerSingleChoice extends BaseAnswer {
  const AnswerSingleChoice({
    super.key,
    required super.onUpdateAnswer,
    required super.answers,
  });

  @override
  BaseAnswerState<AnswerSingleChoice> createState() => _AnswerSingleChoice();
}

class _AnswerSingleChoice extends BaseAnswerState<AnswerSingleChoice> {
  int selectedIndex = 0;

  @override
  Widget buildAnswer(BuildContext context) {
    final answers = widget.answers;

    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: answers.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          Widget createSeparator() {
            if (isSelected) {
              return Divider(color: ColorName.primaryText, height: 15);
            } else {
              return Container();
            }
          }

          return Center(
            child: InkWell(
              child: Column(
                children: [
                  createSeparator(),
                  Text(
                    answers[index].answerText,
                    style: TextStyle(
                      color:
                          isSelected
                              ? ColorName.primaryText
                              : ColorName.secondaryText,
                      fontSize: AppTextSize.textSizeLarge,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  createSeparator(),
                ],
              ),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onUpdateAnswer(answers[index].id);
              },
            ),
          );
        },
      ),
    );
  }
}
