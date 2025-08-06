import 'package:flutter/cupertino.dart';
import 'package:nimble_survey_app/features/surveydetails/model/answer_ui_model.dart';

abstract class BaseAnswer extends StatefulWidget {
  final List<AnswerUiModel> answers;
  final Function(List<AnswerUiModel>, bool shouldHaveAnswerText) onUpdateAnswer;

  const BaseAnswer({
    required this.answers,
    required this.onUpdateAnswer,
    super.key,
  });

  @override
  BaseAnswerState createState();
}

abstract class BaseAnswerState<T extends BaseAnswer> extends State<T> {
  void submitAnswer({
    required List<AnswerUiModel> answers,
    bool shouldHaveAnswerText = false,
  }) {
    widget.onUpdateAnswer(answers, shouldHaveAnswerText);
  }

  Widget buildAnswer(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final answers = widget.answers;

    // TODO show proper empty screen
    if (answers.isEmpty) return Container();

    return buildAnswer(context);
  }
}
