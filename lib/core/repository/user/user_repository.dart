import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

import '../../model/user_model.dart';

abstract class UserRepository {
  Future<Result<UserModel>> getUser({required bool isForceReload});
}
