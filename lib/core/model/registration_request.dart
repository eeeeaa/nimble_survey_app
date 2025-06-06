import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegistrationRequest {
  final RegistrationUser user;
  final String clientId;
  final String clientSecret;

  RegistrationRequest({
    required this.user,
    required this.clientId,
    required this.clientSecret,
  });

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegistrationUser {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  RegistrationUser({
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegistrationUser.fromJson(Map<String, dynamic> json) =>
      _$RegistrationUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationUserToJson(this);
}
