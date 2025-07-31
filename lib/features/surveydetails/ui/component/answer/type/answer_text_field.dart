import 'package:flutter/cupertino.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/base_answer.dart';

import '../../../../../../core/ui/component/nimble_text_field.dart';

class AnswerTextField extends BaseAnswer {
  const AnswerTextField({
    super.key,
    required super.answers,
    required super.onUpdateAnswer,
  });

  @override
  BaseAnswerState<AnswerTextField> createState() => _AnswerTextFieldState();
}

class _AnswerTextFieldState extends BaseAnswerState<AnswerTextField> {
  List<(String, String)> answerPairList = [];

  @override
  Widget buildAnswer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: AppDimension.spacingSmall,
        children: List.generate(widget.answers.length, (index) {
          return NimbleTextField(
            hintText: widget.answers[index].answer ?? '',
            onChanged: (text) {
              // TODO submit the answer on button click
            },
          );
        }),
      ),
    );
  }
}
