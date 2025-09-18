import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/home/model/home_ui_model.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/home_view_model.dart';

import '../../../../mocks/mock_util.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late UserRepository mockUserRepository;
  late LocalStorageRepository mockLocalStorageRepository;

  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockLocalStorageRepository = MockLocalStorageRepository();

    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        userRepositoryProvider.overrideWithValue(mockUserRepository),
        localStorageRepositoryProvider.overrideWithValue(
          mockLocalStorageRepository,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('When view model initialize, it returns initial HomeUiModel', () async {
    // Given
    final expected = HomeUiModel(user: null, isContentLoading: true);

    // When
    final homeUiModel = container.read(homeViewModelProvider);

    // Then
    expect(homeUiModel, expected);
  });

  test(
    'When calling load data, it fetch user data and refresh ui state',
    () async {
      // Given
      final user = MockUtil.mockUserModel;

      // When
      when(
        () => mockUserRepository.getUser(isForceReload: false),
      ).thenAnswer((_) async => Success(user));

      final initialUiState = container.read(homeViewModelProvider);
      expect(initialUiState.user, null);

      await container.read(homeViewModelProvider.notifier).loadData();

      // Then
      final updatedUiState = container.read(homeViewModelProvider);
      expect(updatedUiState.user, user);

      verify(() => mockUserRepository.getUser(isForceReload: false)).called(1);
    },
  );

  test('When calling logout, it logout and clear cache', () async {
    // When
    when(
      () => mockAuthRepository.logout(),
    ).thenAnswer((_) async => Success(null));
    when(
      () => mockLocalStorageRepository.clearAll(),
    ).thenAnswer((_) async => Success(null));

    await container.read(homeViewModelProvider.notifier).logout();

    // Then
    final isLogOutSuccess =
        container.read(homeViewModelProvider).isLogOutSuccess;
    expect(isLogOutSuccess, true);

    verify(() => mockAuthRepository.logout()).called(1);
    verify(() => mockLocalStorageRepository.clearAll()).called(1);
  });
}
