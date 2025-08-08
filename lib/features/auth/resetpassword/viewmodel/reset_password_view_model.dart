import 'package:nimble_survey_app/core/local/service/notification_service.dart';
import 'package:nimble_survey_app/core/provider/network_provider.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/features/auth/resetpassword/model/reset_password_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/repository/auth/auth_repository.dart';

part 'reset_password_view_model.g.dart';

@riverpod
class ResetPasswordViewModel extends _$ResetPasswordViewModel {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);
  late final NotificationService notificationService = ref.watch(
    notificationServiceProvider,
  );

  @override
  ResetPasswordUiModel build() => const ResetPasswordUiModel();

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  Future<void> resetPassword({
    required String? title,
    required String? description,
  }) async {
    state = state.copyWith(isLoading: true);
    await _authRepository.resetPassword(email: state.email);
    if (title != null && description != null) {
      await notificationService.showNotification(title, description);
    }
    state = state.copyWith(isLoading: false);
  }
}
