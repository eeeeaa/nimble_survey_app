import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/user_response.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String? email,
    required String? name,
    required String? avatar,
  }) = _UserEntity;

  factory UserEntity.fromResponse({required UserResponse res}) => UserEntity(
    email: res.data?.attributes?.email,
    name: res.data?.attributes?.name,
    avatar: res.data?.attributes?.avatarUrl,
  );
}
