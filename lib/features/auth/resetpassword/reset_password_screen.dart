import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/component/nimble_login_button.dart';
import '../../../core/ui/component/nimble_text_field.dart';
import '../../../core/ui/theme/app_dimension.dart';
import '../../../core/ui/theme/app_text_size.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../l10n/app_localizations.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  Widget _createResetPasswordForm(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsetsGeometry.directional(
        start: AppDimension.paddingLarge,
        end: AppDimension.paddingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        spacing: AppDimension.spacingMedium,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimension.paddingMedium),
            child: GestureDetector(
              onTap: () {
                context.go('/auth');
              },
              child: Assets.images.icArrowBack.svg(),
            ),
          ),
          SizedBox(
            height: screenHeight / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Center(
                    child: Assets.images.icNimble.svg(fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimension.paddingLarge,
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.resetPasswordDescription ??
                        "",
                    style: TextStyle(
                      color: ColorName.secondaryText,
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          NimbleTextField(
            hintText: AppLocalizations.of(context)?.email ?? "",
            onChanged: (value) {
              // TODO
            },
          ),
          NimbleButton(
            buttonText: AppLocalizations.of(context)?.resetPasswordReset ?? "",
            onPressed: () {
              // TODO
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Assets.images.bgOnboarding.image(fit: BoxFit.cover),
          ),

          // Blurred overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              // Adjust blur strength
              child: Container(color: Colors.black.withAlpha(80)),
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: _createResetPasswordForm(context, ref),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
