import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/constants/app_constants.dart';
import 'package:nimble_survey_app/core/constants/app_widget_key.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/main/my_app.dart';

import '../test/mocks/mock_util.dart';
import '../test/mocks/mocks.dart';
import 'common/integration_test_util.dart';

void main() async {
  final AuthRepository mockAuthRepository = MockAuthRepository();
  final UserRepository mockUserRepository = MockUserRepository();
  final LocalStorageRepository mockLocalStorageRepository =
      MockLocalStorageRepository();
  final SurveyRepository mockSurveyRepository = MockSurveyRepository();

  await setUpIntegrationTesting();

  group('e2e test - authentication', () {
    testWidgets('user successfully login and navigate to home screen', (
      tester,
    ) async {
      when(
        () => mockAuthRepository.isLoggedIn(),
      ).thenAnswer((_) async => false);
      when(
        () => mockAuthRepository.login(any(), any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockUserRepository.getUser(isForceReload: false),
      ).thenAnswer((_) async => Success(MockUtil.mockUserModel));
      when(
        () => mockSurveyRepository.getSurveyList(
          pageNumber: 1,
          pageSize: AppConstants.defaultPageSize,
          isForceReload: false,
        ),
      ).thenAnswer((_) async => Success([MockUtil.mockSurveyModel]));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(mockAuthRepository),
            userRepositoryProvider.overrideWithValue(mockUserRepository),
            localStorageRepositoryProvider.overrideWithValue(
              mockLocalStorageRepository,
            ),
            surveyRepositoryProvider.overrideWithValue(mockSurveyRepository),
          ],
          child: const MyApp(),
        ),
      );

      // Verify splash screen is shown
      expect(find.byKey(AppWidgetKey.splashScreen), findsOneWidget);

      // Wait for splash screen to finish
      await Future.delayed(
        const Duration(
          seconds: AppConstants.splashScreenDelayTimeInSeconds + 3,
        ),
      );

      // Verify login form
      expect(find.byKey(AppWidgetKey.loginEmailTextField), findsOneWidget);
      expect(find.byKey(AppWidgetKey.loginPasswordTextField), findsOneWidget);
      expect(find.byKey(AppWidgetKey.loginResetPasswordButton), findsOneWidget);
      expect(find.byKey(AppWidgetKey.loginSubmitButton), findsOneWidget);

      // Fill in email and password
      await tester.enterText(
        find.byKey(AppWidgetKey.loginEmailTextField),
        'email',
      );
      await tester.enterText(
        find.byKey(AppWidgetKey.loginPasswordTextField),
        'password',
      );

      // Click submit button
      await Future.delayed(const Duration(seconds: 3));
      await tester.tap(find.byKey(AppWidgetKey.loginSubmitButton));

      // Wait for home screen navigation
      await Future.delayed(const Duration(seconds: 3));

      // Verify successful navigation to home
      expect(find.byKey(AppWidgetKey.homeScreen), findsOneWidget);
    });
  });
}
