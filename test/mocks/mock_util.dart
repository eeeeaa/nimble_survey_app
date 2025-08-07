import 'package:nimble_survey_app/core/model/auth_request.dart';
import 'package:nimble_survey_app/core/model/auth_response.dart';
import 'package:nimble_survey_app/core/model/logout_request.dart';
import 'package:nimble_survey_app/core/model/registration_request.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';

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
  static final SurveyResponse mockSurveyResponse = SurveyResponse(
    data: [
      SurveyData(
        id: 'id',
        type: 'type',
        attributes: SurveyAttributes(
          title: 'title',
          description: 'description',
          thankEmailAboveThreshold: 'test',
          thankEmailBelowThreshold: 'thankEmailBelowThreshold',
          isActive: true,
          coverImageUrl: 'url',
          createdAt: 'time',
          activeAt: 'time',
          surveyType: 'type',
        ),
      ),
    ],
    meta: SurveyMeta(page: 1, pages: 10, pageSize: 5, records: 100),
  );

  static final SurveyModel mockSurveyModel = SurveyModel(
    id: 'id',
    title: 'title',
    description: 'description',
    coverImageUrl: 'url',
  );
}
