import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';

class SecureStorageRepositoryImpl extends SecureStorageRepository {
  final FlutterSecureStorage secureStorage;

  SecureStorageRepositoryImpl({required this.secureStorage});

  @override
  Future<Result<String?>> getAccessToken() async {
    return safeApiCall(call: () => secureStorage.read(key: 'access_token'));
  }

  @override
  Future<Result<String?>> getRefreshToken() async {
    return safeApiCall(call: () => secureStorage.read(key: 'refresh_token'));
  }

  @override
  Future<Result<void>> updateAccessToken(String? token) async {
    return safeApiCall(
      call: () => secureStorage.write(key: 'access_token', value: token),
    );
  }

  @override
  Future<Result<void>> updateRefreshToken(String? token) async {
    return safeApiCall(
      call: () => secureStorage.write(key: 'refresh_token', value: token),
    );
  }

  @override
  Future<Result<void>> clearToken() async {
    return safeApiCall(call: () => secureStorage.deleteAll());
  }
}
