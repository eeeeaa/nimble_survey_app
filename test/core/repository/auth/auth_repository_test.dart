import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository_impl.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../../mocks/mock_util.dart';
import '../../../mocks/mocks.dart';

void main() {
  late AuthService mockAuthService;
  late SecureStorageRepository mockSecureStorageRepository;

  late AuthRepository repository;

  setUp(() {
    mockAuthService = MockAuthService();
    mockSecureStorageRepository = MockSecureStorageRepository();

    // Setup fallback data
    registerFallbackValue(MockUtil.mockAuthRequest);
    registerFallbackValue(MockUtil.mockRegistrationRequest);
    registerFallbackValue(MockUtil.mockLogoutRequest);
    registerFallbackValue(MockUtil.mockResetPasswordRequest);

    repository = AuthRepositoryImpl(
      authService: mockAuthService,
      secureStorageRepository: mockSecureStorageRepository,
      clientId: MockUtil.mockClientId,
      clientSecret: MockUtil.mockClientSecret,
    );
  });

  test(
    'When calling login successfully, it returns success response',
    () async {
      // Given
      final email = "email";
      final password = "password";

      // When
      when(
        () => mockAuthService.login(any()),
      ).thenAnswer((_) async => MockUtil.mockAuthResponse);
      when(
        () => mockSecureStorageRepository.updateAccessToken(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockSecureStorageRepository.updateRefreshToken(any()),
      ).thenAnswer((_) async => Success(null));

      final result = await repository.login(email, password);

      // Then
      expect(result, isA<Success<void>>());

      verify(() => mockAuthService.login(any())).called(1);
    },
  );

  test('When calling login failed, it returns warped error', () async {
    // Given
    final email = "email";
    final password = "password";

    // When
    when(() => mockAuthService.login(any())).thenThrow(Exception());
    when(
      () => mockSecureStorageRepository.updateAccessToken(any()),
    ).thenAnswer((_) async => Success(null));
    when(
      () => mockSecureStorageRepository.updateRefreshToken(any()),
    ).thenAnswer((_) async => Success(null));

    final result = await repository.login(email, password);

    // Then
    expect(result, isA<Failure<void>>());

    verify(() => mockAuthService.login(any())).called(1);
  });

  test(
    'When calling register successfully, it returns success response',
    () async {
      // Given
      final email = "email";
      final password = "password";
      final name = "John doe";

      // When
      when(() => mockAuthService.register(any())).thenAnswer((_) async {});

      final result = await repository.register(
        email: email,
        name: name,
        password: password,
        passwordConfirmation: password,
      );

      // Then
      expect(result, isA<Success<void>>());

      verify(() => mockAuthService.register(any())).called(1);
    },
  );

  test('When calling register failed, it returns warped error', () async {
    // Given
    final email = "email";
    final password = "password";
    final name = "John doe";

    // When
    when(() => mockAuthService.register(any())).thenThrow(Exception());

    final result = await repository.register(
      email: email,
      name: name,
      password: password,
      passwordConfirmation: password,
    );

    // Then
    expect(result, isA<Failure<void>>());

    verify(() => mockAuthService.register(any())).called(1);
  });

  test(
    'When calling logout successfully, it returns success response',
    () async {
      // Given
      final accessToken = "token";

      // When
      when(
        () => mockSecureStorageRepository.getAccessToken(),
      ).thenAnswer((_) async => Success(accessToken));
      when(
        () => mockSecureStorageRepository.clearToken(),
      ).thenAnswer((_) async => Success(null));
      when(() => mockAuthService.logout(any())).thenAnswer((_) async {});

      final result = await repository.logout();

      // Then
      expect(result, isA<Success<void>>());

      verify(() => mockAuthService.logout(any())).called(1);
      verify(() => mockSecureStorageRepository.clearToken()).called(1);
    },
  );

  test('When calling logout failed, it returns warped error', () async {
    // Given
    final accessToken = "token";

    // When
    when(
      () => mockSecureStorageRepository.getAccessToken(),
    ).thenAnswer((_) async => Success(accessToken));
    when(
      () => mockSecureStorageRepository.clearToken(),
    ).thenAnswer((_) async => Success(null));
    when(() => mockAuthService.logout(any())).thenThrow(Exception());

    final result = await repository.logout();

    // Then
    expect(result, isA<Failure<void>>());

    verify(() => mockAuthService.logout(any())).called(1);
    verifyNever(() => mockSecureStorageRepository.clearToken());
  });

  test(
    'When calling isLoggedIn successfully, it returns saved isLoggedIn value',
    () async {
      // Given
      final accessToken = "token";

      // When
      when(
        () => mockSecureStorageRepository.getAccessToken(),
      ).thenAnswer((_) async => Success(accessToken));

      final result = await repository.isLoggedIn();

      // Then
      expect(result, true);
    },
  );

  test('When calling isLoggedIn failed, it returns false', () async {
    // When
    when(
      () => mockSecureStorageRepository.getAccessToken(),
    ).thenAnswer((_) async => Failure(Exception()));

    final result = await repository.isLoggedIn();

    // Then
    expect(result, false);
  });

  test(
    'When calling resetPassword successfully, it returns success response',
    () async {
      // Given
      final email = 'email';
      final message = MockUtil.mockResetPasswordResponse.meta?.message;

      // When
      when(
        () => mockAuthService.resetPassword(any()),
      ).thenAnswer((_) async => MockUtil.mockResetPasswordResponse);

      final result = await repository.resetPassword(email: email);

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, message);

      verify(() => mockAuthService.resetPassword(any())).called(1);
    },
  );

  test('When calling resetPassword failed, it returns warped error', () async {
    // Given
    final email = 'email';

    // When
    when(() => mockAuthService.resetPassword(any())).thenThrow(Exception());

    final result = await repository.resetPassword(email: email);

    // Then
    expect(result, isA<Failure>());

    verify(() => mockAuthService.resetPassword(any())).called(1);
  });
}
