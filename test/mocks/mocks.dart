import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nimble_survey_app/core/network/service/auth_service.dart';
import 'package:nimble_survey_app/core/network/service/survey_service.dart';
import 'package:nimble_survey_app/core/network/service/user_service.dart';
import 'package:nimble_survey_app/core/repository/auth/auth_repository.dart';
import 'package:nimble_survey_app/core/repository/local/local_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/local/secure_storage_repository.dart';
import 'package:nimble_survey_app/core/repository/survey/survey_repository.dart';
import 'package:nimble_survey_app/core/repository/surveydetails/survey_details_repository.dart';
import 'package:nimble_survey_app/core/repository/user/user_repository.dart';

class MockAuthService extends Mock implements AuthService {}

class MockSurveyService extends Mock implements SurveyService {}

class MockUserService extends Mock implements UserService {}

class MockLocalStorageRepository extends Mock
    implements LocalStorageRepository {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockSurveyDetailsRepository extends Mock
    implements SurveyDetailsRepository {}

class MockSurveyRepository extends Mock implements SurveyRepository {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
