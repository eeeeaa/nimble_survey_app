import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

import '../../../../../../core/ui/theme/app_text_size.dart';
import '../base_answer.dart';

class AnswerSmiley extends BaseAnswer {
  const AnswerSmiley({
    required super.answers,
    required super.onUpdateAnswer,
    super.key,
  });

  @override
  BaseAnswerState<AnswerSmiley> createState() => _AnswerSmileyState();
}

class _AnswerSmileyState extends BaseAnswerState<AnswerSmiley> {
  int _selectedSmileyIndex = -1;

  final _smileyImages = ['😡', '😕', '😐', '🙂', '😄'];

  @override
  void initState() {
    super.initState();
    // Submit initial answer
    setState(() {
      _selectedSmileyIndex = widget.answers.length - 1;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      submitAnswer(answers: [widget.answers.last]);
    });
  }

  @override
  Widget buildAnswer(BuildContext context) {
    final int totalSmileys = widget.answers.length;

    // Not support more than 5 smileys
    if (totalSmileys > 5) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppDimension.spacingSmall,
      children: List.generate(totalSmileys, (index) {
        final isSelected = index == _selectedSmileyIndex;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedSmileyIndex = index;
            });

            submitAnswer(answers: [widget.answers[index]]);
          },
          child: Opacity(
            opacity: isSelected ? 1.0 : 0.5,
            child: Text(
              _smileyImages[index],
              style: TextStyle(fontSize: AppTextSize.textSizeLarge),
            ),
          ),
        );
      }),
    );
  }
}
