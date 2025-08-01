import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/features/surveydetails/ui/questions/question_list_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/ui/auth_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import '../../features/surveydetails/ui/details/survey_details_screen.dart';

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
      route(path: '/home', child: const HomeScreen()),
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
