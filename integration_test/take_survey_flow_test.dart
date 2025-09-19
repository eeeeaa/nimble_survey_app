import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/constants/app_constants.dart';
import 'package:nimble_survey_app/core/constants/app_widget_key.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/main/my_app.dart';

import '../test/mocks/mock_util.dart';
import '../test/mocks/mocks.dart';
import 'common/integration_test_util.dart';
import 'common/mock_cache_manager.dart';

void main() async {
  final AuthRepository mockAuthRepository = MockAuthRepository();
  final UserRepository mockUserRepository = MockUserRepository();
  final LocalStorageRepository mockLocalStorageRepository =
      MockLocalStorageRepository();
  final SurveyRepository mockSurveyRepository = MockSurveyRepository();
  final SurveyDetailsRepository mockSurveyDetailsRepository =
      MockSurveyDetailsRepository();

  await setUpIntegrationTesting();

  setUpAll(() async {
    CachedNetworkImageProvider.defaultCacheManager = MockCacheManager();

    // Setup fallback data
    registerFallbackValue(MockUtil.mockSubmitSurveyRequest);
  });

  group('e2e test - taking survey', () {
    testWidgets('user complete survey and navigate back to home screen', (
      tester,
    ) async {
      await initializeSurveyStartingFlow(
        tester: tester,
        mockAuthRepository: mockAuthRepository,
        mockUserRepository: mockUserRepository,
        mockLocalStorageRepository: mockLocalStorageRepository,
        mockSurveyRepository: mockSurveyRepository,
        mockSurveyDetailsRepository: mockSurveyDetailsRepository,
      );

      // Navigate to survey details and verify
      await tester.pump(const Duration(seconds: 3));
      expect(find.byKey(AppWidgetKey.surveyDetailsScreen), findsOneWidget);
      expect(find.byKey(AppWidgetKey.surveyDetailsTitle), findsOneWidget);
      expect(find.byKey(AppWidgetKey.surveyDetailsDescription), findsOneWidget);
      expect(
        find.byKey(AppWidgetKey.surveyDetailsStartSurveyButton),
        findsOneWidget,
      );

      // Click start survey
      await tester.tap(find.byKey(AppWidgetKey.surveyDetailsStartSurveyButton));

      // Navigate to survey question screen
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(AppWidgetKey.questionListScreen), findsOneWidget);

      // Submit survey
      when(
        () => mockSurveyDetailsRepository.submitSurvey(any()),
      ).thenAnswer((_) async => Success(null));

      await tester.tap(find.byKey(AppWidgetKey.questionListSubmitSurveyButton));
      await tester.pump(const Duration(seconds: 1));

      // Navigate to survey completed screen then go back to home screen
      expect(find.byKey(AppWidgetKey.surveyCompletedScreen), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      expect(find.byKey(AppWidgetKey.homeScreen), findsOneWidget);
    });

    testWidgets('user close the survey and navigate back to home screen', (
      tester,
    ) async {
      await initializeSurveyStartingFlow(
        tester: tester,
        mockAuthRepository: mockAuthRepository,
        mockUserRepository: mockUserRepository,
        mockLocalStorageRepository: mockLocalStorageRepository,
        mockSurveyRepository: mockSurveyRepository,
        mockSurveyDetailsRepository: mockSurveyDetailsRepository,
      );

      // Navigate to survey details and verify
      await tester.pump(const Duration(seconds: 3));
      expect(find.byKey(AppWidgetKey.surveyDetailsScreen), findsOneWidget);
      expect(find.byKey(AppWidgetKey.surveyDetailsTitle), findsOneWidget);
      expect(find.byKey(AppWidgetKey.surveyDetailsDescription), findsOneWidget);
      expect(
        find.byKey(AppWidgetKey.surveyDetailsStartSurveyButton),
        findsOneWidget,
      );

      // Click start survey
      await tester.tap(find.byKey(AppWidgetKey.surveyDetailsStartSurveyButton));

      // Navigate to survey question screen
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(AppWidgetKey.questionListScreen), findsOneWidget);

      // Click to navigate back
      await tester.tap(find.byKey(AppWidgetKey.questionListNavigateBackButton));

      // Verify Cancel survey popup dialog
      await tester.pump(const Duration(seconds: 1));
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyTitle),
        findsOneWidget,
      );
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyDescription),
        findsOneWidget,
      );
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyPositiveButton),
        findsOneWidget,
      );
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyNegativeButton),
        findsOneWidget,
      );

      // Click cancel
      await tester.tap(
        find.byKey(AppWidgetKey.questionListExitSurveyNegativeButton),
      );

      // The dialog is closed
      await tester.pump(const Duration(seconds: 1));
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyTitle),
        findsNothing,
      );

      // Click to navigate back again
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(AppWidgetKey.questionListNavigateBackButton));

      // Verify Cancel survey popup dialog
      await tester.pump(const Duration(seconds: 1));
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyTitle),
        findsOneWidget,
      );
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyDescription),
        findsOneWidget,
      );
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyPositiveButton),
        findsOneWidget,
      );
      expect(
        find.byKey(AppWidgetKey.questionListExitSurveyNegativeButton),
        findsOneWidget,
      );

      // Click to confirm navigate back
      await tester.tap(
        find.byKey(AppWidgetKey.questionListExitSurveyPositiveButton),
      );

      // Verify home screen
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(AppWidgetKey.homeScreen), findsOneWidget);
    });
  });
}

Future<void> initializeSurveyStartingFlow({
  required WidgetTester tester,
  required AuthRepository mockAuthRepository,
  required UserRepository mockUserRepository,
  required LocalStorageRepository mockLocalStorageRepository,
  required SurveyRepository mockSurveyRepository,
  required SurveyDetailsRepository mockSurveyDetailsRepository,
}) async {
  when(() => mockAuthRepository.isLoggedIn()).thenAnswer((_) async => false);
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
  when(
    () => mockSurveyDetailsRepository.getSurveyDetails(any()),
  ).thenAnswer((_) async => Success(MockUtil.mockSurveyDetailsModel));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        userRepositoryProvider.overrideWithValue(mockUserRepository),
        localStorageRepositoryProvider.overrideWithValue(
          mockLocalStorageRepository,
        ),
        surveyRepositoryProvider.overrideWithValue(mockSurveyRepository),
        surveyDetailsRepositoryProvider.overrideWithValue(
          mockSurveyDetailsRepository,
        ),
      ],
      child: const MyApp(),
    ),
  );

  // Verify splash screen is shown
  expect(find.byKey(AppWidgetKey.splashScreen), findsOneWidget);

  // Wait for splash screen to finish
  await tester.pump(
    const Duration(seconds: AppConstants.splashScreenDelayTimeInSeconds + 3),
  );

  // Verify login form
  expect(find.byKey(AppWidgetKey.loginEmailTextField), findsOneWidget);
  expect(find.byKey(AppWidgetKey.loginPasswordTextField), findsOneWidget);
  expect(find.byKey(AppWidgetKey.loginResetPasswordButton), findsOneWidget);
  expect(find.byKey(AppWidgetKey.loginSubmitButton), findsOneWidget);

  // Fill in email and password
  await tester.enterText(find.byKey(AppWidgetKey.loginEmailTextField), 'email');
  await tester.enterText(
    find.byKey(AppWidgetKey.loginPasswordTextField),
    'password',
  );

  // Click submit button
  await tester.pump(const Duration(seconds: 3));
  await tester.tap(find.byKey(AppWidgetKey.loginSubmitButton));

  // Wait for home screen navigation
  await tester.pump(const Duration(seconds: 3));

  // Verify successful navigation to home
  expect(find.byKey(AppWidgetKey.homeScreen), findsOneWidget);

  // Click on survey
  await tester.tap(find.byKey(AppWidgetKey.surveyItemNavigateToDetailsButton));
}
