import 'package:nimble_survey_app/core/model/user_response.dart';
import 'package:nimble_survey_app/core/network/service/user_service.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../model/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;
  final LocalStorageRepository localStorageRepository;

  UserRepositoryImpl({
    required this.userService,
    required this.localStorageRepository,
  });

  @override
  Future<Result<UserModel>> getUser({required bool isForceReload}) async {
    if (isForceReload) {
      return _getRemoteUser();
    }

    final userCache = await localStorageRepository.getCachedUserProfile();
    if (userCache is Success<UserModel?>) {
      final cachedUser = userCache.data;
      if (cachedUser != null) {
        return Success(cachedUser);
      }
    }

    return _getRemoteUser();
  }

  Future<Result<UserModel>> _getRemoteUser() {
    return safeApiCall<UserResponse, UserModel>(
      call: () => userService.getUser(),
      mapper: (res) {
        final userProfile = UserModel.fromResponse(res: res);
        localStorageRepository.updateCachedUserProfile(userProfile);
        return userProfile;
      },
    );
  }
}
