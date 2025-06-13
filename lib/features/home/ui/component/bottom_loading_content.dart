import 'package:flutter/cupertino.dart';
import 'package:nimble_survey_app/core/ui/component/loading_box.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

class BottomLoadingContent extends StatelessWidget {
  const BottomLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingBox(width: 50, height: 25),
            SizedBox(height: AppDimension.spacingSmall),
            LoadingBox(width: 250, height: 25),
            SizedBox(height: AppDimension.spacingExtraSmall),
            LoadingBox(width: 125, height: 25),
            SizedBox(height: AppDimension.spacingSmall),
            LoadingBox(width: 300, height: 25),
            SizedBox(height: AppDimension.spacingExtraSmall),
            LoadingBox(width: 250, height: 25),
          ],
        ),
      ],
    );
  }
}
