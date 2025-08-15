import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_survey_app/core/local/service/notification_service.dart';
import 'package:nimble_survey_app/core/provider/network_provider.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';

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
    () {},
  );

  test(
    'When calling reset password successfully, it send notification and return successful response',
    () async {},
  );

  test(
    'When calling reset password fail, it returns wrapped error',
    () async {},
  );
}
