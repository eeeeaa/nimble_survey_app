import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/auth_ui_model.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRepository _authRepository;

  @override
  Future<AuthUiModel> build() async {
    _authRepository = ref.watch(authRepositoryProvider);
    final loggedIn = await _authRepository.isLoggedIn();
    return AuthUiModel(isLoggedIn: loggedIn);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    await _authRepository.login(email, password);
    await refreshUiState();
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _authRepository.logout();
    await refreshUiState();
  }

  Future<void> refreshUiState() async {
    state = await AsyncValue.guard(() async {
      final loggedIn = await _authRepository.isLoggedIn();
      return AuthUiModel(isLoggedIn: loggedIn);
    });
  }
}
