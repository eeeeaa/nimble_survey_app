import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/features/home/model/home_ui_model.dart';
import 'package:nimble_survey_app/features/home/model/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/provider/repository_provider.dart';
import '../../../../core/repository/auth/auth_repository.dart';
import '../../../../core/utils/error_wrapper.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  @override
  Future<HomeUiModel?> build() async {
    state = const AsyncValue.loading();
    _authRepository = ref.watch(authRepositoryProvider);
    _userRepository = ref.watch(userRepositoryProvider);
    UserEntity? user = await getUser();
    return HomeUiModel(user: user);
  }

  Future<UserEntity?> getUser() async {
    Result<UserEntity> result = await _userRepository.getUser();
    return result is Success ? (result as Success).data : null;
  }

  Future<Result<void>> logout() async {
    final current = state.value;
    if (current == null) {
      return Failure(Exception("failed to get current state"));
    }

    state = AsyncValue.data(current.copyWith(isLoggingOut: true));
    final result = await _authRepository.logout();
    state = AsyncValue.data(current.copyWith(isLoggingOut: false));
    return result;
  }
}
