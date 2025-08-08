import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ResetPasswordRequest {
  final ResetPasswordUser user;
  final String clientId;
  final String clientSecret;

  ResetPasswordRequest({
    required this.user,
    required this.clientId,
    required this.clientSecret,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordUser {
  final String email;

  ResetPasswordUser({required this.email});

  factory ResetPasswordUser.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordUserFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordUserToJson(this);
}
