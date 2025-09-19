import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_ui_model.freezed.dart';

@freezed
abstract class ResetPasswordUiModel with _$ResetPasswordUiModel {
  const ResetPasswordUiModel._();

  const factory ResetPasswordUiModel({
    @Default('') String email,
    @Default(false) bool isLoading,
    @Default(null) bool? isResetPasswordEmailSent,
  }) = _ResetPasswordUiModel;

  bool get isResetEnabled => email.isNotEmpty;
}
