import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

import '../theme/app_color.dart';
import '../theme/app_text.dart';

class NimbleLoginButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;

  const NimbleLoginButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.borderRadius),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: AppText.textSizeLarge,
            color: AppColor.blackPrimaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => onPressed,
      ),
    );
  }
}
