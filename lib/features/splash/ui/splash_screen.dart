import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

import '../../../core/provider/repository_provider.dart';
import '../../../core/ui/asset/app_image.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 1));
      final isLoggedIn = await authRepository.isLoggedIn();
      if (!context.mounted) return;
      if (isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/auth');
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(AppImage.bgOnboarding, fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Center(
              child: Padding(
                padding: EdgeInsetsGeometry.all(AppDimension.paddingLarge),
                child: Image.asset(AppImage.icNimbleSplash, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
