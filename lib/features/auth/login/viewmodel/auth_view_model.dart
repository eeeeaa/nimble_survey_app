import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/error_wrapper.dart';
import '../model/auth_ui_model.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);

  @override
  AuthUiModel build() => AuthUiModel();

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _authRepository.login(email, password);
    if (result is Success) {
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } else {
      state = state.copyWith(isLoading: false, isLoggedIn: false);
    }
  }
}
