import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nimble_survey_app/core/model/auth_request.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final AuthService authService;
  final String clientId;
  final String clientSecret;

  AuthInterceptor({
    required this.secureStorage,
    required this.authService,
    required this.clientId,
    required this.clientSecret,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: 'access_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      if (refreshToken != null) {
        try {
          final newToken = await authService.refresh(
            AuthRequest.forRefresh(
              refreshToken: refreshToken,
              clientId: clientId,
              clientSecret: clientSecret,
            ),
          );

          await secureStorage.write(
            key: 'access_token',
            value: newToken.data.attributes.accessToken,
          );
          await secureStorage.write(
            key: 'refresh_token',
            value: newToken.data.attributes.refreshToken,
          );

          final retryRequest = err.requestOptions;
          retryRequest.headers['Authorization'] =
              'Bearer ${newToken.data.attributes.accessToken}';

          final response = await Dio().fetch(retryRequest);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}
