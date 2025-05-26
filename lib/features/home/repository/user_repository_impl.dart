import 'package:nimble_survey_app/core/model/user_response.dart';
import 'package:nimble_survey_app/core/network/service/user_service.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/home/model/user_entity.dart';
import 'package:nimble_survey_app/features/home/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<Result<UserEntity>> getUser() async {
    return safeApiCall<UserResponse, UserEntity>(
      call: () => userService.getUser(),
      mapper: (res) => UserEntity.fromResponse(res: res),
    );
  }
}
