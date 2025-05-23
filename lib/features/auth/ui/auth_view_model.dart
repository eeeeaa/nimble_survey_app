import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/features/auth/model/auth_ui_state.dart';
import 'package:nimble_survey_app/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRepository _authRepository;

  @override
  Future<AuthUiState> build() async {
    _authRepository = ref.watch(authRepositoryProvider);
    final loggedIn = await _authRepository.isLoggedIn();
    return AuthUiState(isLoggedIn: loggedIn);
  }

  Future<void> login(String email, String password) async {
    await _authRepository.login(email, password);
    await refreshUiState();
  }

  Future<void> logout() async {
    await _authRepository.logout();
    await refreshUiState();
  }

  Future<void> refreshUiState() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final loggedIn = await _authRepository.isLoggedIn();
      return AuthUiState(isLoggedIn: loggedIn);
    });
  }
}

