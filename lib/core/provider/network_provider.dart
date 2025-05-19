import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/auth_intercepter.dart';
import '../network/service/auth_service.dart';
import '../network/service/survey_service.dart';

part 'network_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
Dio dio(Ref ref) {
  return Dio();
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

@riverpod
AuthService authService(Ref ref) {
  final dio = ref.watch(dioProvider);
  final baseUrl = ref.watch(baseUrlProvider);
  return AuthService(dio, baseUrl: baseUrl);
}

@riverpod
SurveyService surveyService(Ref ref) {
  final dio = ref.watch(dioProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  final authService = ref.watch(authServiceProvider);
  final storage = ref.watch(secureStorageProvider);
  final clientId = ref.watch(clientIdProvider);
  final clientSecret = ref.watch(clientSecretProvider);

  dio.interceptors.add(
    AuthInterceptor(
      secureStorage: storage,
      authService: authService,
      clientId: clientId,
      clientSecret: clientSecret,
    ),
  );

  return SurveyService(dio, baseUrl: baseUrl);
}
