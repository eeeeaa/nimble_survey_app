import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

import '../../../../gen/colors.gen.dart';
import '../../theme/app_text_size.dart';
import '../nimble_button.dart';

class BaseNimbleErrorScreen extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String description;
  final String primaryButtonLabel;
  final VoidCallback? onPressed;

  const BaseNimbleErrorScreen({
    this.icon,
    this.title = "",
    this.description = "",
    this.primaryButtonLabel = "",
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimension.spacingMedium),
            child: Column(
              spacing: AppDimension.spacingMedium,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon ?? SizedBox.shrink(),
                Text(
                  title,
                  style: TextStyle(
                    color: ColorName.primaryText,
                    fontSize: AppTextSize.textSizeLarge,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: ColorName.secondaryText,
                    fontSize: AppTextSize.textSizeMedium,
                  ),
                ),
                NimbleButton(
                  buttonText: primaryButtonLabel,
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
