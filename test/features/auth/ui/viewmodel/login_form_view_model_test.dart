import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_survey_app/features/auth/model/login_form_ui_model.dart';
import 'package:nimble_survey_app/features/auth/ui/viewmodel/login_form_view_model.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('When view model initialize, it returns initial LoginFormUiModel', () {
    // Given
    final expected = LoginFormUiModel(email: '', password: '');

    // When
    final loginFormUiModel = container.read(loginFormViewModelProvider);

    // Then
    expect(loginFormUiModel, expected);
  });

  test('When updating email, it update ui state with the updated email', () {
    final email = 'email';
    final initialUiState = container.read(loginFormViewModelProvider);

    expect(initialUiState.email, '');

    container.read(loginFormViewModelProvider.notifier).setEmail(email);

    final updatedUiState = container.read(loginFormViewModelProvider);

    expect(updatedUiState.email, email);
  });

  test(
    'When updating password, it update ui state with the updated password',
    () async {
      final password = 'password';
      final initialUiState = container.read(loginFormViewModelProvider);

      expect(initialUiState.password, '');

      container.read(loginFormViewModelProvider.notifier).setPassword(password);

      final updatedUiState = container.read(loginFormViewModelProvider);

      expect(updatedUiState.password, password);
    },
  );
}
