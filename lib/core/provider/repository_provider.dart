import 'package:nimble_survey_app/features/auth/repository/auth_repository_impl.dart';
import 'package:nimble_survey_app/features/home/repository/user_repository.dart';
import 'package:nimble_survey_app/features/home/repository/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/repository/auth_repository.dart';
import 'network_provider.dart';

part 'repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final authService = ref.read(authServiceProvider);
  final storage = ref.read(secureStorageProvider);
  final clientId = ref.read(clientIdProvider);
  final clientSecret = ref.read(clientSecretProvider);

  return AuthRepositoryImpl(
    authService: authService,
    secureStorage: storage,
    clientId: clientId,
    clientSecret: clientSecret,
  );
}

@riverpod
UserRepository userRepository(Ref ref) {
  final userService = ref.read(userServiceProvider);

  return UserRepositoryImpl(userService: userService);
}
