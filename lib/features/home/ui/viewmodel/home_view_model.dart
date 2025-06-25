import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/features/home/model/home_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/model/user_model.dart';
import '../../../../core/provider/repository_provider.dart';
import '../../../../core/repository/auth/auth_repository.dart';
import '../../../../core/utils/error_wrapper.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);
  late final UserRepository _userRepository = ref.watch(userRepositoryProvider);

  @override
  HomeUiModel build() => HomeUiModel(user: null, isContentLoading: true);

  Future<void> loadData() async {
    state = state.copyWith(isContentLoading: true);
    final UserModel? user = await _getUser();

    state = state.copyWith(user: user, isContentLoading: false);
  }

  Future<UserModel?> _getUser() async {
    final result = await _userRepository.getUser();
    return result is Success ? (result as Success).data : null;
  }

  Future<Result<void>> logout() async {
    state = state.copyWith(isLoggingOut: true);
    final result = await _authRepository.logout();
    state = state.copyWith(isLoggingOut: false);
    return result;
  }
}
