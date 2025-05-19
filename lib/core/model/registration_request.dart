import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegistrationRequest {
  final RegistrationUser user;

  @JsonKey(name: 'client_id')
  final String clientId;

  @JsonKey(name: 'client_secret')
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

@JsonSerializable()
class RegistrationUser {
  final String email;
  final String name;
  final String password;

  @JsonKey(name: 'password_confirmation')
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
