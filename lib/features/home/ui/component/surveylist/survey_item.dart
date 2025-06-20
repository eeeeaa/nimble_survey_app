import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';

import '../../../../../core/ui/theme/app_dimension.dart';
import '../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';

class SurveyItem extends StatelessWidget {
  final SurveyData? survey;

  const SurveyItem({required this.survey, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'bullet',
              style: TextStyle(
                color: ColorName.primaryText,
                fontSize: AppTextSize.textSizeSmall,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              survey?.attributes?.title ?? 'Unknown survey',
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
                    survey?.attributes?.description ?? 'No description',
                    style: TextStyle(
                      color: ColorName.secondaryText,
                      fontSize: AppTextSize.textSizeLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(AppDimension.surveyCircleButtonDiameter / 4),
                  ),
                  onPressed: () {
                    // TODO
                  },
                  child: Assets.images.icArrowNext.svg(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
