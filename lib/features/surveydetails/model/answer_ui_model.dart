import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_ui_model.freezed.dart';

@freezed
abstract class AnswerUiModel with _$AnswerUiModel {
  const factory AnswerUiModel({required String itemId, String? answer}) =
      _AnswerUiModel;
}
