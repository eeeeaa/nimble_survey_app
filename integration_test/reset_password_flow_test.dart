import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/constants/app_constants.dart';
import 'package:nimble_survey_app/core/constants/app_widget_key.dart';
import 'package:nimble_survey_app/core/local/service/notification_service.dart';
import 'package:nimble_survey_app/core/provider/network_provider.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/main/my_app.dart';

import '../test/mocks/mock_util.dart';
import '../test/mocks/mocks.dart';
import 'common/integration_test_util.dart';

void main() async {
  final AuthRepository mockAuthRepository = MockAuthRepository();
  final UserRepository mockUserRepository = MockUserRepository();
  final NotificationService mockNotificationService = MockNotificationService();

  await setUpIntegrationTesting();

  group('e2e test - reset password', () {
    testWidgets(
      'user navigate to reset password, then submit their email to receive password reset email',
      (tester) async {
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
          () => mockNotificationService.isInitialized,
        ).thenAnswer((_) => true);
        when(
          () => mockNotificationService.initNotification(),
        ).thenAnswer((_) async {});

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWithValue(mockAuthRepository),
              userRepositoryProvider.overrideWithValue(mockUserRepository),
              notificationServiceProvider.overrideWithValue(
                mockNotificationService,
              ),
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
        expect(
          find.byKey(AppWidgetKey.loginResetPasswordButton),
          findsOneWidget,
        );
        expect(find.byKey(AppWidgetKey.loginSubmitButton), findsOneWidget);

        // Click on reset password
        await tester.tap(find.byKey(AppWidgetKey.loginResetPasswordButton));

        // Wait for navigation
        await Future.delayed(const Duration(seconds: 3));

        // Verify reset password screen
        expect(find.byKey(AppWidgetKey.resetPasswordLogo), findsOneWidget);
        expect(
          find.byKey(AppWidgetKey.resetPasswordDescription),
          findsOneWidget,
        );
        expect(
          find.byKey(AppWidgetKey.resetPasswordEmailTextField),
          findsOneWidget,
        );
        expect(
          find.byKey(AppWidgetKey.resetPasswordSubmitButton),
          findsOneWidget,
        );

        // fill in email
        await tester.enterText(
          find.byKey(AppWidgetKey.resetPasswordEmailTextField),
          'email',
        );

        // Submit
        when(
          () => mockAuthRepository.resetPassword(email: any(named: 'email')),
        ).thenAnswer((_) async => Success('Text'));
        when(
          () => mockNotificationService.showNotification(any(), any()),
        ).thenAnswer((_) async => {});
        await tester.tap(find.byKey(AppWidgetKey.resetPasswordSubmitButton));
      },
    );
  });
}
