import 'package:dio/dio.dart';
import 'package:nimble_survey_app/core/model/user_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  // Need to add logger due to: https://github.com/trevorwang/retrofit.dart/issues/745
  factory UserService(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _UserService;

  @GET('/me')
  Future<UserResponse> getUser();
}
