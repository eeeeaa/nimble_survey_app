import 'package:nimble_survey_app/features/home/model/user_entity.dart';

class AuthUiModel {
  final bool isLoggedIn;

  const AuthUiModel({required this.isLoggedIn});

  AuthUiModel copyWith({required bool isLoggedIn}) {
    return AuthUiModel(isLoggedIn: isLoggedIn);
  }
}
