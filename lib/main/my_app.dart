import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/provider/navigation_provider.dart';
import 'package:nimble_survey_app/core/ui/theme/app_text.dart';

import '../l10n/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

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
