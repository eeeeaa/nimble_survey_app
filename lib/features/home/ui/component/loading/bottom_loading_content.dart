import 'package:flutter/cupertino.dart';
import 'package:nimble_survey_app/core/ui/component/loading_box.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

class BottomLoadingContent extends StatelessWidget {
  const BottomLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final contentWidth =
        screenWidth - (AppDimension.homeBottomLoadingContentHorizontalPadding);
    double baseHeight =
        screenHeight * AppDimension.homeBottomLoadingContentHeightRatio;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: contentWidth),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeBottomLoadingContentWidthRatioFirstRow,
                height: baseHeight,
              ),
              SizedBox(height: AppDimension.spacingSmall),
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeBottomLoadingContentWidthRatioSecondRow,
                height: baseHeight,
              ),
              SizedBox(height: AppDimension.spacingExtraSmall),
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeBottomLoadingContentWidthRatioThirdRow,
                height: baseHeight,
              ),
              SizedBox(height: AppDimension.spacingSmall),
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeBottomLoadingContentWidthRatioFourthRow,
                height: baseHeight,
              ),
              SizedBox(height: AppDimension.spacingExtraSmall),
              LoadingBox(
                width:
                    contentWidth *
                    AppDimension.homeBottomLoadingContentWidthRatioFifthRow,
                height: baseHeight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
