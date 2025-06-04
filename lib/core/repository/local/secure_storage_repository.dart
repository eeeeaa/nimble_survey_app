import '../../utils/error_wrapper.dart';

abstract class SecureStorageRepository {
  Future<Result<String?>> getAccessToken();

  Future<Result<String?>> getRefreshToken();

  Future<Result<void>> updateAccessToken(String token);

  Future<Result<void>> updateRefreshToken(String token);

  Future<Result<void>> clearToken();
}
