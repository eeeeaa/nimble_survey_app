import 'package:nimble_survey_app/core/repository/auth/auth_repository_impl.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository_impl.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository_impl.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/auth/auth_repository.dart';
import 'network_provider.dart';

part 'repository_provider.g.dart';

@riverpod
SecureStorageRepository secureStorageRepository(Ref ref) {
  final storage = ref.watch(secureStorageProvider);

  return SecureStorageRepositoryImpl(secureStorage: storage);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  final secureStorageRepository = ref.watch(secureStorageRepositoryProvider);
  final clientId = ref.watch(clientIdProvider);
  final clientSecret = ref.watch(clientSecretProvider);

  return AuthRepositoryImpl(
    authService: authService,
    secureStorageRepository: secureStorageRepository,
    clientId: clientId,
    clientSecret: clientSecret,
  );
}

@riverpod
UserRepository userRepository(Ref ref) {
  final userService = ref.watch(userServiceProvider);

  return UserRepositoryImpl(userService: userService);
}

@riverpod
SurveyRepository surveyRepository(Ref ref) {
  final surveyService = ref.watch(surveyServiceProvider);

  return SurveyRepositoryImpl(surveyService: surveyService);
}
