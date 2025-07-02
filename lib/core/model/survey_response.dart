import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final List<SurveyData>? data;
  final SurveyMeta? meta;

  SurveyResponse({required this.data, required this.meta});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}

@JsonSerializable()
class SurveyData {
  final String? id;
  final String? type;
  final SurveyAttributes? attributes;

  SurveyData({required this.id, required this.type, required this.attributes});

  factory SurveyData.fromJson(Map<String, dynamic> json) =>
      _$SurveyDataFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyAttributes {
  final String? title;
  final String? description;
  final String? thankEmailAboveThreshold;
  final String? thankEmailBelowThreshold;
  final bool? isActive;
  final String? coverImageUrl;
  final String? createdAt;
  final String? activeAt;
  final String? inactiveAt;
  final String? surveyType;

  SurveyAttributes({
    required this.title,
    required this.description,
    required this.thankEmailAboveThreshold,
    required this.thankEmailBelowThreshold,
    required this.isActive,
    required this.coverImageUrl,
    required this.createdAt,
    required this.activeAt,
    this.inactiveAt,
    required this.surveyType,
  });

  factory SurveyAttributes.fromJson(Map<String, dynamic> json) =>
      _$SurveyAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyAttributesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyMeta {
  final int? page;
  final int? pages;
  final int? pageSize;
  final int? records;

  SurveyMeta({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  factory SurveyMeta.fromJson(Map<String, dynamic> json) =>
      _$SurveyMetaFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyMetaToJson(this);
}
