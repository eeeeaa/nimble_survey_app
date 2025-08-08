import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_ui_model.freezed.dart';

@freezed
abstract class ResetPasswordUiModel with _$ResetPasswordUiModel {
  const ResetPasswordUiModel._(); // Allows adding custom getters

  const factory ResetPasswordUiModel({@Default('') String email}) =
      _ResetPasswordUiModel;

  bool get isResetEnabled => email.isNotEmpty;
}
