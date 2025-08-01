import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../theme/app_dimension.dart';
import '../theme/app_text_size.dart';

class NimbleTextArea extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final String? suffixText;
  final Function()? onButtonPressed;

  const NimbleTextArea({
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

    return Expanded(
      child: SingleChildScrollView(
        child: TextField(
          minLines: 6,
          maxLines: null,
          keyboardType: TextInputType.multiline,
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
        ),
      ),
    );
  }
}
