import 'package:flutter/cupertino.dart';
import 'package:nimble_survey_app/core/model/survey_answer_model.dart';

abstract class BaseAnswer extends StatefulWidget {
  final List<SurveyAnswerModel> answers;
  final Function(String) onUpdateAnswer;

  const BaseAnswer({
    required this.answers,
    required this.onUpdateAnswer,
    super.key,
  });

  @override
  BaseAnswerState createState();
}

abstract class BaseAnswerState<T extends BaseAnswer> extends State<T> {
  void submitAnswer(String answer) {
    widget.onUpdateAnswer(answer);
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
