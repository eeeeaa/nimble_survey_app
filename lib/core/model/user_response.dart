import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final UserData? data;

  UserResponse({required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final String? id;
  final String? type;
  final UserAttributes? attributes;

  UserData({required this.id, required this.type, required this.attributes});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserAttributes {
  final String? email;
  final String? name;
  final String? avatarUrl;

  UserAttributes({
    required this.email,
    required this.name,
    required this.avatarUrl,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);
}
