import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';

import '../../../core/provider/repository_provider.dart';
import '../../../gen/assets.gen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  _initialize() async {
    // Only read once at launch
    final authRepository = ref.read(authRepositoryProvider);
    await Future.delayed(const Duration(seconds: 1));
    final isLoggedIn = await authRepository.isLoggedIn();
    if (!mounted) return;
    context.go(isLoggedIn ? '/home' : '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(child: Assets.images.bgOnboarding.image(fit: BoxFit.cover)),

          Positioned.fill(
            child: Center(
              child: Padding(
                padding: EdgeInsetsGeometry.all(AppDimension.paddingExtraLarge),
                child: Assets.images.icNimbleSplash.image(fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
