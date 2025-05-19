import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  @JsonKey(name: 'grant_type')
  final String grantType;
  final String? email;
  final String? password;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  AuthRequest({
    required this.grantType,
    this.email,
    this.password,
    this.refreshToken,
    required this.clientId,
    required this.clientSecret,
  });

  factory AuthRequest.forLogin({
    required String email,
    required String password,
    required String clientId,
    required String clientSecret,
  }) => AuthRequest(
    grantType: 'password',
    email: email,
    password: password,
    clientId: clientId,
    clientSecret: clientSecret,
  );

  factory AuthRequest.forRefresh({
    required String refreshToken,
    required String clientId,
    required String clientSecret,
  }) => AuthRequest(
    grantType: 'refresh_token',
    refreshToken: refreshToken,
    clientId: clientId,
    clientSecret: clientSecret,
  );

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
