import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/base_answer.dart';
import 'package:wheel_picker/wheel_picker.dart';

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

  Widget _createSeparator(bool isSelected) {
    if (isSelected) {
      return Divider(
        color: ColorName.primaryText,
        height: AppDimension.spacingSmall,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget buildAnswer(BuildContext context) {
    final answers = widget.answers;

    return WheelPicker(
      itemCount: answers.length,
      builder: (context, index) {
        final isSelected = selectedIndex == index;
        return Column(
          children: [
            _createSeparator(isSelected),
            Text(
              answers[index].answer ?? '',
              style: TextStyle(
                color:
                    isSelected
                        ? ColorName.primaryText
                        : ColorName.secondaryText,
                fontSize: AppTextSize.textSizeLarge,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            _createSeparator(isSelected),
          ],
        );
      },
      onIndexChanged: (index, interactionType) {
        setState(() {
          selectedIndex = index;
        });
        submitAnswer([answers[index]]);
      },
      style: WheelPickerStyle(
        itemExtent: AppTextSize.textSizeLarge + (3 * AppDimension.spacingSmall),
        squeeze: AppDimension.wheelPickerSqueezeSize,
      ),
      looping: false,
    );
  }
}
