import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/login_form_ui_model.dart';

part 'login_form_view_model.g.dart';

@riverpod
class LoginFormViewModel extends _$LoginFormViewModel {
  @override
  LoginFormUiModel build() => const LoginFormUiModel();

  void setEmail(String value) {
    // TODO add email validation
    state = state.copyWith(email: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }
}
