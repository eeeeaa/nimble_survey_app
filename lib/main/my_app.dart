import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/ui/theme/app_text.dart';

import '../features/auth/ui/auth_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/splash/ui/splash_screen.dart';
import '../l10n/app_localizations.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Neuzeit',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: AppText.textSizeLarge),
          bodyMedium: TextStyle(fontSize: AppText.textSizeMedium),
        ),
      ),
      routerConfig: router,
      title: 'Nimble Survey App',
    );
  }
}
