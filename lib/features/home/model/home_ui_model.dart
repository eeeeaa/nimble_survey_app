import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/model/user_model.dart';

part 'home_ui_model.freezed.dart';

@freezed
abstract class HomeUiModel with _$HomeUiModel {
  const factory HomeUiModel({
    required UserModel? user,
    @Default(true) bool isContentLoading,
    @Default(false) bool isLoggingOut,
  }) = _HomeUiModel;
}
