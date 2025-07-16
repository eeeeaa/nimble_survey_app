import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';

import '../../../../../core/ui/theme/app_dimension.dart';
import '../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';

class SurveyItem extends StatelessWidget {
  final SurveyModel survey;
  final int listLength;
  final PageController controller;

  const SurveyItem({
    required this.survey,
    required this.listLength,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          survey.title,
          style: TextStyle(
            color: ColorName.primaryText,
            fontSize: AppTextSize.textSizeXXL,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                survey.description,
                style: TextStyle(
                  color: ColorName.secondaryText,
                  fontSize: AppTextSize.textSizeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(
                  AppDimension.surveyCircleButtonDiameter / 4,
                ),
              ),
              onPressed: () {
                context.push('/survey/${survey.id}');
              },
              child: Assets.images.icArrowNext.svg(),
            ),
          ],
        ),
      ],
    );
  }
}
