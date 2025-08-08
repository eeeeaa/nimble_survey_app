import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/features/auth/resetpassword/model/reset_password_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/repository/auth/auth_repository.dart';
import '../../../../core/utils/error_wrapper.dart';

part 'reset_password_view_model.g.dart';

@riverpod
class ResetPasswordViewModel extends _$ResetPasswordViewModel {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);

  @override
  ResetPasswordUiModel build() => const ResetPasswordUiModel();

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  Future<void> resetPassword() async {
    state = state.copyWith(isLoading: true);
    final result = await _authRepository.resetPassword(email: state.email);
    state = state.copyWith(isLoading: false);

    if (result is Success) {
      // TODO also send local notification
    }
  }
}
