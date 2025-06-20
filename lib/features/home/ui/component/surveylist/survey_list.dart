import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_background_image.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_item.dart';

import '../../../model/home_ui_model.dart';

class SurveyList extends StatelessWidget {
  final HomeUiModel? uiModel;

  const SurveyList({required this.uiModel, super.key});

  @override
  Widget build(BuildContext context) {
    return uiModel?.surveyList.isNotEmpty ?? false
        ? PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: uiModel?.surveyList.length ?? 0,
          controller: PageController(viewportFraction: 1.0),
          itemBuilder: (context, index) {
            SurveyData? currentSurvey = uiModel?.surveyList.elementAt(index);
            return Stack(
              children: [
                SurveyBackgroundImage(imageUrl: currentSurvey?.attributes?.coverImageUrl ?? ''),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimension.paddingMedium),
                    child: SurveyItem(survey: currentSurvey),
                  ),
                ),
              ],
            );
          },
        )
        : Spacer();
  }
}
