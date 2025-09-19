import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  final ResetPasswordMeta? meta;

  ResetPasswordResponse({this.meta});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}

@JsonSerializable()
class ResetPasswordMeta {
  final String? message;

  ResetPasswordMeta({this.message});

  factory ResetPasswordMeta.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordMetaToJson(this);
}
