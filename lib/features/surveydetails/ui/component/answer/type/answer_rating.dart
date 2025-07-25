// TODO handle showing answers as rating bar with icon (thumbs up, smile, etc.)
import 'package:flutter/material.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/base_answer.dart';

class AnswerRating extends BaseAnswer {
  final Image iconActive;
  final Image iconInActive;

  const AnswerRating({
    required this.iconActive,
    required this.iconInActive,
    required super.answers,
    required super.onUpdateAnswer,
    super.key,
  });

  @override
  BaseAnswerState<AnswerRating> createState() => _AnswerFiveRatingState();
}

class _AnswerFiveRatingState extends BaseAnswerState<AnswerRating> {
  int _selectedRating = 0;

  @override
  Widget buildAnswer(BuildContext context) {
    final int totalStars = widget.answers.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalStars, (index) {
        final isSelected = index < _selectedRating;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = index + 1;
              submitAnswer([widget.answers[index]]);
            });
          },
          child: isSelected ? widget.iconActive : widget.iconInActive,
        );
      }),
    );
  }
}
