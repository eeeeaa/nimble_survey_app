import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/core/ui/theme/app_text_size.dart';
import 'package:nimble_survey_app/gen/colors.gen.dart';

class NimbleTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final String? suffixText;
  final Function()? onButtonPressed;

  const NimbleTextField({
    required this.hintText,
    required this.onChanged,
    this.suffixText,
    this.onButtonPressed,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextButton? suffixButton =
        suffixText != null
            ? TextButton(
              onPressed: onButtonPressed,
              child: Text(
                suffixText ?? "",
                style: TextStyle(
                  fontSize: AppTextSize.textSizeSmall,
                  color: ColorName.secondaryText,
                ),
              ),
            )
            : null;

    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: ColorName.primaryText),
      decoration: InputDecoration(
        suffixIcon: suffixButton,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimension.borderRadius),
          ),
        ),
        filled: true,
        fillColor: Colors.white.withAlpha(25),
        hintText: hintText,
        hintStyle: TextStyle(color: ColorName.secondaryText),
      ),
      onChanged: onChanged,
    );
  }
}
