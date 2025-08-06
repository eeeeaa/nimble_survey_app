import 'package:nimble_survey_app/core/model/auth_response.dart';

class MockUtil {
  MockUtil._();

  static final String mockClientId = "mockId";
  static final String mockClientSecret = "mockSecret";
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
