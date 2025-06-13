import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/component/loading_box.dart';
import 'package:nimble_survey_app/core/ui/component/loading_circle.dart';

import '../../../../core/ui/theme/app_dimension.dart';

class TopShimmerContent extends StatelessWidget {
  const TopShimmerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimension.spacingSmall,
          children: [
            LoadingBox(width: 130, height: 16),
            LoadingBox(width: 110, height: 16),
          ],
        ),
        LoadingCircle(radius: 18),
      ],
    );
  }
}
