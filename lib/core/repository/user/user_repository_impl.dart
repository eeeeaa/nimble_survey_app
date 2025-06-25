import 'package:nimble_survey_app/core/model/user_response.dart';
import 'package:nimble_survey_app/core/network/service/user_service.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../model/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<Result<UserModel>> getUser() async {
    return safeApiCall<UserResponse, UserModel>(
      call: () => userService.getUser(),
      mapper: (res) => UserModel.fromResponse(res: res),
    );
  }
}
