import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final AuthData? data;

  AuthResponse({required this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class AuthData {
  final String? id;
  final String? type;
  final AuthAttributes? attributes;

  AuthData({required this.id, required this.type, required this.attributes});

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthAttributes {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? refreshToken;
  final int? createdAt;

  AuthAttributes({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory AuthAttributes.fromJson(Map<String, dynamic> json) =>
      _$AuthAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AuthAttributesToJson(this);
}
