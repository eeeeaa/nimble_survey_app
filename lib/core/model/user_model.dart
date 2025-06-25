import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nimble_survey_app/core/model/user_response.dart';

part 'user_model.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String? email,
    required String? name,
    required String? avatar,
  }) = _UserModel;

  factory UserModel.fromResponse({required UserResponse res}) => UserModel(
    email: res.data?.attributes?.email,
    name: res.data?.attributes?.name,
    avatar: res.data?.attributes?.avatarUrl,
  );
}
