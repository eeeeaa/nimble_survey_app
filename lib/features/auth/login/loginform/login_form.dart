import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_login_button.dart';
import 'package:nimble_survey_app/core/ui/component/nimble_text_field.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../../core/ui/theme/app_dimension.dart';
import '../../../../core/ui/theme/app_text_size.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../viewmodel/auth_view_model.dart';
import '../viewmodel/login_form_view_model.dart';

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
            child: Center(child: Assets.images.icNimble.svg(fit: BoxFit.fill)),
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
                suffix:
                    authUiModel.isLoading
                        ? Padding(
                          padding: const EdgeInsets.all(
                            AppDimension.spacingMedium,
                          ),
                          child: CircularProgressIndicator(),
                        )
                        : TextButton(
                          onPressed: () {
                            context.go('/auth/reset');
                          },
                          child: Text(
                            AppLocalizations.of(context)?.loginForgotPassword ??
                                "",
                            style: TextStyle(
                              fontSize: AppTextSize.textSizeSmall,
                              color: ColorName.secondaryText,
                            ),
                          ),
                        ),
                hintText: AppLocalizations.of(context)?.loginPassword ?? "",
                obscureText: true,
                onChanged:
                    (value) => ref
                        .read(loginFormViewModelProvider.notifier)
                        .setPassword(value),
              ),
              authUiModel.isLoading
                  ? CircularProgressIndicator()
                  : NimbleButton(
                    buttonText: AppLocalizations.of(context)?.login ?? "",
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (loginFormUiModel.isLoginEnabled == false) return;
                      final result = await ref
                          .read(authViewModelProvider.notifier)
                          .login(
                            loginFormUiModel.email,
                            loginFormUiModel.password,
                          );

                      if (context.mounted == false) return;
                      if (result is Success) {
                        context.go('/home');
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              AppLocalizations.of(
                                context,
                              )?.loginInvalidEmailPassword ??
                              "",
                        );
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
