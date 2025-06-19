import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/component/loading_box.dart';
import 'package:nimble_survey_app/core/ui/component/loading_circle.dart';

import '../../../../../core/ui/theme/app_dimension.dart';

class TopLoadingContent extends StatelessWidget {
  const TopLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final contentWidth =
        screenWidth * AppDimension.homeTopLoadingContentWidthRatio;
    final baseHeight =
        screenHeight * AppDimension.homeTopLoadingContentHeightRatio;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: contentWidth),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeTopLoadingContentWidthRatioFirstRow,
                height: baseHeight,
              ),
              SizedBox(height: AppDimension.spacingSmall),
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeTopLoadingContentWidthRatioSecondRow,
                height: baseHeight,
              ),
            ],
          ),
          LoadingCircle(
            radius:
                (screenWidth *
                    AppDimension.homeTopLoadingContentAvatarRadiusRatio) /
                2,
          ),
        ],
      ),
    );
  }
}
