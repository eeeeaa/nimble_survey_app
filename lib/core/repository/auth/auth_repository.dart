import '../../utils/error_wrapper.dart';

abstract class AuthRepository {
  Future<Result<void>> login(String email, String password);

  Future<Result<void>> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
  });

  Future<Result<void>> logout();

  Future<bool> isLoggedIn();

  Future<Result<String?>> resetPassword({required String email});
}
