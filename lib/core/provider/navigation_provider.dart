import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/features/auth/resetpassword/reset_password_screen.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/question_list_screen.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/survey_completed_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/login/auth_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import '../../features/surveydetails/ui/survey_details_screen.dart';

part 'navigation_provider.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
    );
  }

  GoRoute route({required String path, required Widget child}) {
    return GoRoute(
      path: path,
      pageBuilder:
          (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: child,
          ),
    );
  }

  return GoRouter(
    initialLocation: '/',
    routes: [
      route(path: '/', child: const SplashScreen()),
      route(path: '/auth', child: const AuthScreen()),
      route(path: '/auth/reset', child: const ResetPasswordScreen()),
      route(path: '/home', child: const HomeScreen()),
      route(path: '/survey/completed', child: const SurveyCompletedScreen()),
      GoRoute(
        path: '/survey/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: SurveyDetailsScreen(id: id),
          );
        },
      ),
      GoRoute(
        path: '/survey/:id/survey-sessions',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: QuestionListScreen(),
          );
        },
      ),
    ],
  );
}
