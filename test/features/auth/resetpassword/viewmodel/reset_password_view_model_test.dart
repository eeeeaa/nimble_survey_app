import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/local/service/notification_service.dart';
import 'package:nimble_survey_app/core/provider/network_provider.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/auth/resetpassword/model/reset_password_ui_model.dart';
import 'package:nimble_survey_app/features/auth/resetpassword/viewmodel/reset_password_view_model.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late NotificationService mockNotificationService;

  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockNotificationService = MockNotificationService();

    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        notificationServiceProvider.overrideWithValue(mockNotificationService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'When view model initialize, it returns initial ResetPasswordUiModel',
    () {
      // Given
      final expected = ResetPasswordUiModel(email: '');

      // When
      final resetPasswordUiModel = container.read(
        resetPasswordViewModelProvider,
      );

      // Then
      expect(resetPasswordUiModel, expected);
    },
  );

  test('When updating email, it update ui state with the updated email', () {
    // Given
    final initialExpected = ResetPasswordUiModel(email: '');
    final updatedExpected = ResetPasswordUiModel(email: 'email');

    // When
    final initialUiState = container.read(resetPasswordViewModelProvider);
    expect(initialUiState, initialExpected);

    // Then
    container.read(resetPasswordViewModelProvider.notifier).setEmail('email');
    final updatedUiState = container.read(resetPasswordViewModelProvider);
    expect(updatedUiState, updatedExpected);
  });

  test(
    'When calling reset password successfully, it send notification and return successful response',
    () async {
      // Given
      final email = 'email';
      final noticeTitle = 'title';
      final noticeDescription = 'description';

      // When
      when(
        () => mockAuthRepository.resetPassword(email: email),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockNotificationService.showNotification(any(), any()),
      ).thenAnswer((_) async => {});

      container.read(resetPasswordViewModelProvider.notifier).setEmail(email);

      await container
          .read(resetPasswordViewModelProvider.notifier)
          .resetPassword(title: noticeTitle, description: noticeDescription);

      // Then
      final isResetPasswordEmailSent =
          container
              .read(resetPasswordViewModelProvider)
              .isResetPasswordEmailSent;
      expect(isResetPasswordEmailSent, true);

      verify(() => mockAuthRepository.resetPassword(email: email)).called(1);
      verify(
        () => mockNotificationService.showNotification(
          noticeTitle,
          noticeDescription,
        ),
      ).called(1);
    },
  );

  test('When calling reset password fail, it returns wrapped error', () async {
    // Given
    final email = 'email';
    final noticeTitle = 'title';
    final noticeDescription = 'description';

    // When
    when(
      () => mockAuthRepository.resetPassword(email: email),
    ).thenAnswer((_) async => Failure(Exception()));
    when(
      () => mockNotificationService.showNotification(any(), any()),
    ).thenAnswer((_) async => {});

    container.read(resetPasswordViewModelProvider.notifier).setEmail(email);

    await container
        .read(resetPasswordViewModelProvider.notifier)
        .resetPassword(title: noticeTitle, description: noticeDescription);

    // Then
    final isResetPasswordEmailSent =
        container.read(resetPasswordViewModelProvider).isResetPasswordEmailSent;
    expect(isResetPasswordEmailSent, false);

    verify(() => mockAuthRepository.resetPassword(email: email)).called(1);
    verifyNever(() => mockNotificationService.showNotification(any(), any()));
  });
}
