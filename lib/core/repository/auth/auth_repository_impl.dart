import 'dart:async';

import 'package:nimble_survey_app/core/model/auth_request.dart';
import 'package:nimble_survey_app/core/model/auth_response.dart';
import 'package:nimble_survey_app/core/model/logout_request.dart';
import 'package:nimble_survey_app/core/model/registration_request.dart';
import 'package:nimble_survey_app/core/model/reset_password_request.dart';
import 'package:nimble_survey_app/core/model/reset_password_response.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;
  final SecureStorageRepository secureStorageRepository;
  final String clientId;
  final String clientSecret;

  AuthRepositoryImpl({
    required this.authService,
    required this.secureStorageRepository,
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
        final attr = res.data?.attributes;
        await secureStorageRepository.updateAccessToken(attr?.accessToken);
        await secureStorageRepository.updateRefreshToken(attr?.refreshToken);
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
    final result = await secureStorageRepository.getAccessToken();

    if (result is Success<String?>) {
      final token = result.data;

      if (token == null || token.isEmpty) {
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
          await secureStorageRepository.clearToken();
        },
      );
    } else {
      return Failure(Exception("failed to get token"));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final result = await secureStorageRepository.getAccessToken();
    if (result is Success<String?>) {
      final token = result.data;
      return token != null && token.isNotEmpty;
    } else {
      return false;
    }
  }

  @override
  Future<Result<String?>> resetPassword({required String email}) async {
    return safeApiCall<ResetPasswordResponse, String?>(
      call:
          () => authService.resetPassword(
            ResetPasswordRequest(
              user: ResetPasswordUser(email: email),
              clientId: clientId,
              clientSecret: clientSecret,
            ),
          ),
      mapper: (res) async => res.meta?.message,
    );
  }
}
