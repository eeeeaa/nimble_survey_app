import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nimble_survey_app/core/network/service/user_service.dart';
import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../local/database.dart';
import '../network/auth_interceptor.dart';
import '../network/service/auth_service.dart';
import '../network/service/survey_service.dart';

part 'network_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();

  dio.interceptors.add(PrettyDioLogger(requestBody: true, enabled: kDebugMode));

  return dio;
}

@riverpod
Dio authorizedDio(Ref ref) {
  final dio = Dio();
  final authService = ref.watch(authServiceProvider);
  final secureStorageRepository = ref.watch(secureStorageRepositoryProvider);
  final clientId = ref.watch(clientIdProvider);
  final clientSecret = ref.watch(clientSecretProvider);

  dio.interceptors.add(
    AuthInterceptor(
      secureStorageRepository: secureStorageRepository,
      authService: authService,
      clientId: clientId,
      clientSecret: clientSecret,
    ),
  );

  dio.interceptors.add(PrettyDioLogger(requestBody: true, enabled: kDebugMode));

  return dio;
}

@riverpod
String baseUrl(Ref ref) {
  return dotenv.env['API_ENDPOINT'] ?? '';
}

@riverpod
String clientId(Ref ref) {
  return dotenv.env['CLIENT_ID'] ?? '';
}

@riverpod
String clientSecret(Ref ref) {
  return dotenv.env['CLIENT_SECRET'] ?? '';
}

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) => AppDatabase();

@riverpod
AuthService authService(Ref ref) {
  final dio = ref.watch(dioProvider);
  final baseUrl = ref.watch(baseUrlProvider);
  return AuthService(dio, baseUrl: baseUrl);
}

@riverpod
UserService userService(Ref ref) {
  final dio = ref.watch(authorizedDioProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  return UserService(dio, baseUrl: baseUrl);
}

@riverpod
SurveyService surveyService(Ref ref) {
  final dio = ref.watch(authorizedDioProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  return SurveyService(dio, baseUrl: baseUrl);
}
