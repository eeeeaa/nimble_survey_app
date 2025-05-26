class LoginFormUiModel {
  final String email;
  final String password;

  const LoginFormUiModel({this.email = '', this.password = ''});

  bool get isLoginEnabled => email.isNotEmpty && password.isNotEmpty;

  LoginFormUiModel copyWith({String? email, String? password}) {
    return LoginFormUiModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
