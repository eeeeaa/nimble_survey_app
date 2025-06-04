import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_ui_model.freezed.dart';

@freezed
abstract class LoginFormUiModel with _$LoginFormUiModel {
  const LoginFormUiModel._(); // Allows adding custom getters

  const factory LoginFormUiModel({
    @Default('') String email,
    @Default('') String password,
  }) = _LoginFormUiModel;

  bool get isLoginEnabled => email.isNotEmpty && password.isNotEmpty;
}
