import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/provider/navigation_provider.dart';
import 'package:nimble_survey_app/core/ui/theme/app_text_size.dart';
import 'package:nimble_survey_app/gen/fonts.gen.dart';

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
        dividerColor: Colors.transparent,
        dividerTheme: DividerThemeData(color: Colors.transparent),
        fontFamily: FontFamily.neuzeit,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: AppTextSize.textSizeMedium),
          bodyMedium: TextStyle(fontSize: AppTextSize.textSizeSmall),
        ),
      ),
      routerConfig: router,
      title: 'Nimble Survey App',
    );
  }
}
