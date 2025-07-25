// TODO show answer as nps list (1 to 10 bar)
import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/component/answer/base_answer.dart';

import '../../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../../l10n/app_localizations.dart';

class AnswerNps extends BaseAnswer {
  const AnswerNps({
    super.key,
    required super.answers,
    required super.onUpdateAnswer,
  });

  @override
  BaseAnswerState<AnswerNps> createState() => _AnswerNpsState();
}

class _AnswerNpsState extends BaseAnswerState<AnswerNps> {
  int? _selectedIndex;

  Widget _createNpsBarItem({required int index, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          submitAnswer([widget.answers[index]]);
        });
      },
      child: Container(
        width: 32,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppDimension.npsBorderRadius),
        ),
        child: Text(
          widget.answers[index].answer ?? '',
          style: TextStyle(
            color: isSelected ? Colors.grey : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _createNpsBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.answers.length, (index) {
            final isSelected = _selectedIndex == index;

            return _createNpsBarItem(index: index, isSelected: isSelected);
          }),
        ),
        const SizedBox(height: AppDimension.spacingSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)?.numberRatingBarAnswerNegativeText ??
                  "",
              style: TextStyle(
                color: ColorName.primaryText,
                fontSize: AppTextSize.textSizeMedium,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              AppLocalizations.of(context)?.numberRatingBarAnswerPositiveText ??
                  "",
              style: TextStyle(
                color: ColorName.primaryText,
                fontSize: AppTextSize.textSizeMedium,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildAnswer(BuildContext context) {
    return _createNpsBar();
  }
}
