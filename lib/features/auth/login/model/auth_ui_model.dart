import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_ui_model.freezed.dart';

@freezed
abstract class AuthUiModel with _$AuthUiModel {
  const factory AuthUiModel({required bool isLoggedIn}) = _AuthUiModel;
}
