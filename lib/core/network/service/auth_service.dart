import 'package:dio/dio.dart';
import 'package:nimble_survey_app/core/model/logout_request.dart';
import 'package:nimble_survey_app/core/model/reset_password_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../model/auth_request.dart';
import '../../model/auth_response.dart';
import '../../model/registration_request.dart';
import '../../model/reset_password_request.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  // Need to add logger due to: https://github.com/trevorwang/retrofit.dart/issues/745
  factory AuthService(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AuthService;

  @POST("/oauth/token")
  Future<AuthResponse> login(@Body() AuthRequest body);

  @POST("/oauth/token")
  Future<AuthResponse> refresh(@Body() AuthRequest body);

  @POST("/oauth/revoke")
  Future<void> logout(@Body() LogoutRequest body);

  @POST("/registrations")
  Future<void> register(@Body() RegistrationRequest request);

  @POST("/password")
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
