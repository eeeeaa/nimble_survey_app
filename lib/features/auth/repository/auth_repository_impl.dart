import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nimble_survey_app/core/model/auth_request.dart';
import 'package:nimble_survey_app/core/model/auth_response.dart';
import 'package:nimble_survey_app/core/model/logout_request.dart';
import 'package:nimble_survey_app/core/model/registration_request.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/auth/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  final String clientId;
  final String clientSecret;

  AuthRepositoryImpl({
    required this.authService,
    required this.secureStorage,
    required this.clientId,
    required this.clientSecret,
  });

  @override
  Future<Result<void>> login(String email, String password) async {
    return safeApiCall<AuthResponse, void>(
      call:
          () => authService.login(
            AuthRequest.forLogin(
              email: email,
              password: password,
              clientId: clientId,
              clientSecret: clientSecret,
            ),
          ),
      mapper: (res) async {
        final attr = res.data.attributes;
        await secureStorage.write(key: 'access_token', value: attr.accessToken);
        await secureStorage.write(
          key: 'refresh_token',
          value: attr.refreshToken,
        );
        return;
      },
    );
  }

  @override
  Future<Result<void>> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
  }) async {
    return safeApiCall(
      call:
          () => authService.register(
            RegistrationRequest(
              user: RegistrationUser(
                email: email,
                name: name,
                password: password,
                passwordConfirmation: passwordConfirmation,
              ),
              clientId: clientId,
              clientSecret: clientSecret,
            ),
          ),
    );
  }

  @override
  Future<Result<void>> logout() async {
    final token = await secureStorage.read(key: 'access_token');
    if (token == null) {
      return Failure(Exception("no token found"));
    }

    return safeApiCall(
      call:
          () => authService.logout(
            LogoutRequest(
              token: token,
              clientId: clientId,
              clientSecret: clientSecret,
            ),
          ),
      mapper: (response) async {
        await secureStorage.deleteAll();
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }
}
