import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/auth/login/model/auth_ui_model.dart';
import 'package:nimble_survey_app/features/auth/login/viewmodel/auth_view_model.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;

  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();

    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockAuthRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('When view model initialize, it returns initial AuthUiModel', () {
    // Given
    final expected = AuthUiModel(isLoggedIn: null);

    // When
    final authUiModel = container.read(authViewModelProvider);

    // Then
    expect(authUiModel, expected);
  });

  test('When calling login, it calls login and refresh ui state', () async {
    // Given
    final email = "email";
    final password = "password";

    // When
    when(() => mockAuthRepository.isLoggedIn()).thenAnswer((_) async => false);
    when(
      () => mockAuthRepository.login(any(), any()),
    ).thenAnswer((_) async => Success(null));
    when(() => mockAuthRepository.isLoggedIn()).thenAnswer((_) async => true);

    // Then
    await container.read(authViewModelProvider.notifier).login(email, password);

    final updatedUiState = container.read(authViewModelProvider);
    expect(updatedUiState.isLoggedIn, true);

    verify(() => mockAuthRepository.login(email, password)).called(1);
  });
}
