import 'package:dio/dio.dart';
import 'package:nimble_survey_app/core/model/auth_request.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageRepository secureStorageRepository;
  final AuthService authService;
  final String clientId;
  final String clientSecret;

  AuthInterceptor({
    required this.secureStorageRepository,
    required this.authService,
    required this.clientId,
    required this.clientSecret,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await secureStorageRepository.getAccessToken();
    if (result is Success<String?>) {
      final token = result.data;
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      }
    }

    // reject if there's no token
    return handler.reject(
      DioException(
        requestOptions: options,
        type: DioExceptionType.unknown,
        error: Exception("No access token found"),
      ),
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle refresh api when token expired
    if (err.response?.statusCode == 401) {
      final result = await secureStorageRepository.getRefreshToken();
      if (result is Success<String?>) {
        final token = result.data;
        if (token != null) {
          try {
            final newToken = await authService.refresh(
              AuthRequest.forRefresh(
                refreshToken: token,
                clientId: clientId,
                clientSecret: clientSecret,
              ),
            );

            await secureStorageRepository.updateAccessToken(
              newToken.data?.attributes?.accessToken,
            );
            await secureStorageRepository.updateRefreshToken(
              newToken.data?.attributes?.refreshToken,
            );

            final retryRequest = err.requestOptions;
            retryRequest.headers['Authorization'] =
                'Bearer ${newToken.data?.attributes?.accessToken}';

            final response = await Dio().fetch(retryRequest);
            return handler.resolve(response);
          } catch (_) {
            return handler.next(err);
          }
        }
      }
    }
    return handler.next(err);
  }
}
