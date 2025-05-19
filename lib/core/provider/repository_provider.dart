import 'package:nimble_survey_app/features/auth/repository/auth_repository_impl.dart';
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

  return AuthRepositoryImpl(authService, storage, clientId, clientSecret);
}
