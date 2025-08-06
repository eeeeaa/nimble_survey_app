import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';

class MockAuthService extends Mock implements AuthService {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}
