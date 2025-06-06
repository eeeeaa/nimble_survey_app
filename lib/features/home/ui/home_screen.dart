import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../auth/ui/viewmodel/auth_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUiModel = ref.watch(authViewModelProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Assets.images.bgOnboarding.image(fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Home screen dummy",
                    style: TextStyle(color: ColorName.primaryText),
                  ),
                  authUiModel.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () async {
                          final result =
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .logout();

                          if (!context.mounted) return;

                          if (result is Success) {
                            context.go('/auth');
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  AppLocalizations.of(
                                    context,
                                  )?.homeLogoutFailed ??
                                  "",
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)?.homeLogout ?? '',
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
