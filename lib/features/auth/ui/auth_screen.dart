import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimble_survey_app/core/ui/asset/app_image.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_login_button.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_text_field.dart';
import 'package:nimble_survey_app/features/auth/ui/auth_view_model.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../core/ui/theme/app_dimension.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsetsGeometry.directional(
        start: AppDimension.paddingLarge,
        end: AppDimension.paddingLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: screenHeight / 3,
            child: Center(
              child: SvgPicture.asset(AppImage.icNimbleSvg, fit: BoxFit.fill),
            ),
          ),
          Column(
            spacing: AppDimension.spacingMedium,
            children: [
              NimbleTextField(
                hintText: AppLocalizations.of(context)?.email ?? "",
              ),
              NimbleTextField(
                suffixText:
                    AppLocalizations.of(context)?.loginForgotPassword ?? "",
                hintText: AppLocalizations.of(context)?.loginPassword ?? "",
                obscureText: true,
              ),
              NimbleLoginButton(
                buttonText: AppLocalizations.of(context)?.login ?? "",
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUiState = ref.watch(authViewModelProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(AppImage.bgOnboarding, fit: BoxFit.cover),
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
            child: SafeArea(child: SingleChildScrollView(child: LoginForm())),
          ),
        ],
      ),
    );
  }
}
