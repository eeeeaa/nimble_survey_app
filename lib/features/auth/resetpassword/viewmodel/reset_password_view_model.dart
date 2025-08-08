import 'package:nimble_survey_app/core/provider/repository_provider.dart';
import 'package:nimble_survey_app/features/auth/resetpassword/model/reset_password_ui_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/repository/auth/auth_repository.dart';

part 'reset_password_view_model.g.dart';

@riverpod
class ResetPasswordViewModel extends _$ResetPasswordViewModel {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);

  @override
  ResetPasswordUiModel build() => const ResetPasswordUiModel();
}
