import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/ui/asset/app_image.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_login_button.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_text_field.dart';
import 'package:nimble_survey_app/features/auth/ui/auth_view_model.dart';
import 'package:nimble_survey_app/features/auth/ui/login_form_view_model.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../core/ui/theme/app_dimension.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final authUiModel = ref.watch(authViewModelProvider);
    final loginFormUiModel = ref.watch(loginFormViewModelProvider);

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
                onChanged:
                    (value) => ref
                        .read(loginFormViewModelProvider.notifier)
                        .setEmail(value),
              ),
              NimbleTextField(
                suffixText:
                    AppLocalizations.of(context)?.loginForgotPassword ?? "",
                hintText: AppLocalizations.of(context)?.loginPassword ?? "",
                obscureText: true,
                onChanged:
                    (value) => ref
                        .read(loginFormViewModelProvider.notifier)
                        .setPassword(value),
              ),
              authUiModel.isLoading
                  ? CircularProgressIndicator()
                  : NimbleLoginButton(
                    buttonText: AppLocalizations.of(context)?.login ?? "",
                    onPressed: () async {
                      await ref
                          .read(authViewModelProvider.notifier)
                          .login(
                            loginFormUiModel.email,
                            loginFormUiModel.password,
                          );
                      if (authUiModel.value?.isLoggedIn == true) {
                        if (context.mounted) context.go('/home');
                      } else {
                        // TODO show error from result wrapper
                        Fluttertoast.showToast(msg: 'login failed');
                      }
                    },
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
