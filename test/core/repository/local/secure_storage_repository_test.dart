import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository_impl.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../../mocks/mocks.dart';

void main() {
  late FlutterSecureStorage mockFlutterSecureStorage;

  late SecureStorageRepository repository;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();

    repository = SecureStorageRepositoryImpl(
      secureStorage: mockFlutterSecureStorage,
    );
  });

  test(
    'When calling getAccessToken successfully, it returns success response',
    () async {
      // Given
      final token = "token";

      // When
      when(
        () => mockFlutterSecureStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => token);

      final result = await repository.getAccessToken();

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, token);

      verify(
        () => mockFlutterSecureStorage.read(key: 'access_token'),
      ).called(1);
    },
  );

  test('When calling getAccessToken failed, it returns warped error', () async {
    // When
    when(
      () => mockFlutterSecureStorage.read(key: 'access_token'),
    ).thenThrow(Exception());

    final result = await repository.getAccessToken();

    // Then
    expect(result, isA<Failure>());

    verify(() => mockFlutterSecureStorage.read(key: 'access_token')).called(1);
  });

  test(
    'When calling getRefreshToken successfully, it returns success response',
    () async {
      // Given
      final token = "token";

      // When
      when(
        () => mockFlutterSecureStorage.read(key: 'refresh_token'),
      ).thenAnswer((_) async => token);

      final result = await repository.getRefreshToken();

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, token);

      verify(
        () => mockFlutterSecureStorage.read(key: 'refresh_token'),
      ).called(1);
    },
  );

  test(
    'When calling getRefreshToken failed, it returns warped error',
    () async {
      // When
      when(
        () => mockFlutterSecureStorage.read(key: 'refresh_token'),
      ).thenThrow(Exception());

      final result = await repository.getRefreshToken();

      // Then
      expect(result, isA<Failure>());

      verify(
        () => mockFlutterSecureStorage.read(key: 'refresh_token'),
      ).called(1);
    },
  );

  test(
    'When calling updateAccessToken successfully, it returns success response',
    () async {
      // Given
      final token = "token";

      // When
      when(
        () => mockFlutterSecureStorage.write(key: 'access_token', value: token),
      ).thenAnswer((_) async => token);

      final result = await repository.updateAccessToken(token);

      // Then
      expect(result, isA<Success>());

      verify(
        () => mockFlutterSecureStorage.write(key: 'access_token', value: token),
      ).called(1);
    },
  );
  test(
    'When calling updateAccessToken failed, it returns warped error',
    () async {
      // Given
      final token = "token";

      // When
      when(
        () => mockFlutterSecureStorage.write(key: 'access_token', value: token),
      ).thenThrow(Exception());

      final result = await repository.updateAccessToken(token);

      // Then
      expect(result, isA<Failure>());

      verify(
        () => mockFlutterSecureStorage.write(key: 'access_token', value: token),
      ).called(1);
    },
  );

  test(
    'When calling updateRefreshToken successfully, it returns success response',
    () async {
      // Given
      final token = "token";

      // When
      when(
        () =>
            mockFlutterSecureStorage.write(key: 'refresh_token', value: token),
      ).thenAnswer((_) async => token);

      final result = await repository.updateRefreshToken(token);

      // Then
      expect(result, isA<Success>());

      verify(
        () =>
            mockFlutterSecureStorage.write(key: 'refresh_token', value: token),
      ).called(1);
    },
  );
  test(
    'When calling updateRefreshToken failed, it returns warped error',
    () async {
      // Given
      final token = "token";

      // When
      when(
        () =>
            mockFlutterSecureStorage.write(key: 'refresh_token', value: token),
      ).thenThrow(Exception());

      final result = await repository.updateRefreshToken(token);

      // Then
      expect(result, isA<Failure>());

      verify(
        () =>
            mockFlutterSecureStorage.write(key: 'refresh_token', value: token),
      ).called(1);
    },
  );

  test(
    'When calling clearToken successfully, it returns success response',
    () async {
      // When
      when(() => mockFlutterSecureStorage.deleteAll()).thenAnswer((_) async {});

      final result = await repository.clearToken();

      // Then
      expect(result, isA<Success>());

      verify(() => mockFlutterSecureStorage.deleteAll()).called(1);
    },
  );
  test('When calling clearToken failed, it returns warped error', () async {
    // When
    when(() => mockFlutterSecureStorage.deleteAll()).thenThrow(Exception());

    final result = await repository.clearToken();

    // Then
    expect(result, isA<Failure>());

    verify(() => mockFlutterSecureStorage.deleteAll()).called(1);
  });
}
