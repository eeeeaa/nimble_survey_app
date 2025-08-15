import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/ui/theme/app_text_size.dart';
import 'package:nimble_survey_app/gen/colors.gen.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../gen/assets.gen.dart';

class SurveyCompletedScreen extends StatefulWidget {
  const SurveyCompletedScreen({super.key});

  @override
  State<SurveyCompletedScreen> createState() => _SurveyCompletedScreenState();
}

class _SurveyCompletedScreenState extends State<SurveyCompletedScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.black)),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.lotties.surveyCompleted.lottie(
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                Text(
                  AppLocalizations.of(context)?.surveyCompletionDefaultText ??
                      '',
                  style: TextStyle(
                    color: ColorName.primaryText,
                    fontSize: AppTextSize.textSizeXL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
