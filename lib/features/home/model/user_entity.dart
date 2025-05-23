import 'package:nimble_survey_app/core/model/user_response.dart';

class UserEntity {
  final String email;
  final String name;
  final String avatar;

  UserEntity({required this.email, required this.name, required this.avatar});

  factory UserEntity.fromResponse({required UserResponse res}) => UserEntity(
    email: res.data.attributes.email,
    name: res.data.attributes.name,
    avatar: res.data.attributes.avatarUrl,
  );
}
