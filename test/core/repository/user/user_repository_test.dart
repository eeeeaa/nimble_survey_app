import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/network/service/user_service.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository_impl.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../../mocks/mock_util.dart';
import '../../../mocks/mocks.dart';

void main() {
  late LocalStorageRepository mockLocalStorageRepository;
  late UserService mockUserService;

  late UserRepository repository;

  setUp(() {
    mockLocalStorageRepository = MockLocalStorageRepository();
    mockUserService = MockUserService();

    // Setup fallback data
    registerFallbackValue(MockUtil.mockUserModel);

    repository = UserRepositoryImpl(
      userService: mockUserService,
      localStorageRepository: mockLocalStorageRepository,
    );
  });

  test(
    'When calling getUser successfully without cache, it fetch remote and returns successful response',
    () async {
      // When
      when(
        () => mockLocalStorageRepository.getCachedUserProfile(),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockLocalStorageRepository.updateCachedUserProfile(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockUserService.getUser(),
      ).thenAnswer((_) async => MockUtil.mockUserResponse);

      final result = await repository.getUser(isForceReload: false);

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, MockUtil.mockUserModel);

      verify(() => mockLocalStorageRepository.getCachedUserProfile()).called(1);
      verify(() => mockUserService.getUser()).called(1);
    },
  );
  test(
    'When calling getUser successfully with existing cache, it returns cache data',
    () async {
      // When
      when(
        () => mockLocalStorageRepository.getCachedUserProfile(),
      ).thenAnswer((_) async => Success(MockUtil.mockUserModel));
      when(
        () => mockLocalStorageRepository.updateCachedUserProfile(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockUserService.getUser(),
      ).thenAnswer((_) async => MockUtil.mockUserResponse);

      final result = await repository.getUser(isForceReload: false);

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, MockUtil.mockUserModel);

      verify(() => mockLocalStorageRepository.getCachedUserProfile()).called(1);
      verifyNever(() => mockUserService.getUser());
    },
  );
  test(
    'When calling getUser with isForceReload, it fetch remote even if cache exists',
    () async {
      // When
      when(
        () => mockLocalStorageRepository.getCachedUserProfile(),
      ).thenAnswer((_) async => Success(MockUtil.mockUserModel));
      when(
        () => mockLocalStorageRepository.updateCachedUserProfile(any()),
      ).thenAnswer((_) async => Success(null));
      when(
        () => mockUserService.getUser(),
      ).thenAnswer((_) async => MockUtil.mockUserResponse);

      final result = await repository.getUser(isForceReload: true);

      // Then
      expect(result, isA<Success>());
      expect((result as Success).data, MockUtil.mockUserModel);

      verifyNever(() => mockLocalStorageRepository.getCachedUserProfile());
      verify(() => mockUserService.getUser()).called(1);
    },
  );

  test('When calling getUser failed, it returns warped error', () async {
    // When
    when(
      () => mockLocalStorageRepository.getCachedUserProfile(),
    ).thenAnswer((_) async => Success(null));
    when(
      () => mockLocalStorageRepository.updateCachedUserProfile(any()),
    ).thenAnswer((_) async => Success(null));
    when(() => mockUserService.getUser()).thenThrow(Exception());

    final result = await repository.getUser(isForceReload: false);

    // Then
    expect(result, isA<Failure>());

    verify(() => mockLocalStorageRepository.getCachedUserProfile()).called(1);
    verify(() => mockUserService.getUser()).called(1);
  });
}
