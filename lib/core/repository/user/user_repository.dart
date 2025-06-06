import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/home/model/user_entity.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> getUser();
}
