import 'package:nimble_survey_app/core/model/auth_request.dart';
import 'package:nimble_survey_app/core/model/auth_response.dart';
import 'package:nimble_survey_app/core/model/logout_request.dart';
import 'package:nimble_survey_app/core/model/registration_request.dart';

class MockUtil {
  MockUtil._();

  static final String mockClientId = "mockId";
  static final String mockClientSecret = "mockSecret";
  static final AuthRequest mockAuthRequest = AuthRequest(
    grantType: '',
    clientId: '',
    clientSecret: '',
  );
  static final RegistrationRequest mockRegistrationRequest =
      RegistrationRequest(
        user: RegistrationUser(
          email: '',
          name: '',
          password: '',
          passwordConfirmation: '',
        ),
        clientId: '',
        clientSecret: '',
      );
  static final LogoutRequest mockLogoutRequest = LogoutRequest(
    token: '',
    clientId: '',
    clientSecret: '',
  );
  static final AuthResponse mockAuthResponse = AuthResponse(
    data: AuthData(
      id: "id",
      type: "type",
      attributes: AuthAttributes(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 10,
        refreshToken: 'refreshToken',
        createdAt: 1,
      ),
    ),
  );
}
