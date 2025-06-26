import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

import '../../../gen/colors.gen.dart';
import '../theme/app_text_size.dart';

class NimbleButton extends StatelessWidget {
  final String buttonText;
  final double? width;
  final VoidCallback? onPressed;

  const NimbleButton({
    required this.buttonText,
    required this.onPressed,
    this.width = double.infinity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: AppTextSize.textSizeLarge,
            color: ColorName.blackPrimaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
