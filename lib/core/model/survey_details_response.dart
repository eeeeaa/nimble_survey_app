import 'package:json_annotation/json_annotation.dart';

part 'survey_details_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SurveyDetailsResponse {
  final SurveyDetailsDataWrapper? data;
  final List<SurveyDetailsIncludedItem>? included;

  SurveyDetailsResponse({this.data, this.included});

  factory SurveyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SurveyDetailsDataWrapper {
  final String? id;
  final String? type;
  final SurveyDetailsAttributes? attributes;
  final SurveyDetailsRelationships? relationships;

  SurveyDetailsDataWrapper({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory SurveyDetailsDataWrapper.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsDataWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsDataWrapperToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyDetailsAttributes {
  final String? title;
  final String? description;
  final String? thankEmailAboveThreshold;
  final String? thankEmailBelowThreshold;
  final bool? isActive;
  final String? coverImageUrl;
  final DateTime? createdAt;
  final DateTime? activeAt;
  final DateTime? inactiveAt;
  final String? surveyType;

  SurveyDetailsAttributes({
    this.title,
    this.description,
    this.thankEmailAboveThreshold,
    this.thankEmailBelowThreshold,
    this.isActive,
    this.coverImageUrl,
    this.createdAt,
    this.activeAt,
    this.inactiveAt,
    this.surveyType,
  });

  factory SurveyDetailsAttributes.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsAttributesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SurveyDetailsRelationships {
  final SurveyDetailsRelationshipDataList? questions;

  SurveyDetailsRelationships({this.questions});

  factory SurveyDetailsRelationships.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsRelationshipsFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsRelationshipsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyDetailsRelationshipDataList {
  final List<SurveyDetailsIdTypePair>? data;

  SurveyDetailsRelationshipDataList({this.data});

  factory SurveyDetailsRelationshipDataList.fromJson(
    Map<String, dynamic> json,
  ) => _$SurveyDetailsRelationshipDataListFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SurveyDetailsRelationshipDataListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyDetailsIdTypePair {
  final String? id;
  final String? type;

  SurveyDetailsIdTypePair({this.id, this.type});

  factory SurveyDetailsIdTypePair.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsIdTypePairFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsIdTypePairToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SurveyDetailsIncludedItem {
  final String? id;
  final String? type;
  final SurveyDetailsItemAttributes? attributes;
  final SurveyDetailsItemRelationships? relationships;

  SurveyDetailsIncludedItem({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory SurveyDetailsIncludedItem.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsIncludedItemFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsIncludedItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyDetailsItemAttributes {
  // Shared fields
  final String? text;
  final String? helpText;
  final int? displayOrder;
  final String? shortText;
  final bool? isMandatory;
  final String? displayType;

  // Answer-specific
  final String? inputMaskPlaceholder;
  final bool? isCustomerFirstName;
  final bool? isCustomerLastName;
  final bool? isCustomerTitle;
  final bool? isCustomerEmail;
  final bool? promptCustomAnswer;
  final String? inputMask;
  final String? dateConstraint;
  final String? defaultValue;
  final String? responseClass;
  final String? referenceIdentifier;
  final int? score;

  // Question-specific
  final String? pick;
  final String? correctAnswerId;
  final String? facebookProfile;
  final String? twitterProfile;
  final String? imageUrl;
  final String? coverImageUrl;
  final double? coverImageOpacity;
  final String? coverBackgroundColor;
  final bool? isShareableOnFacebook;
  final bool? isShareableOnTwitter;
  final String? fontFace;
  final String? fontSize;
  final String? tagList;

  SurveyDetailsItemAttributes({
    // Shared
    this.text,
    this.helpText,
    this.displayOrder,
    this.shortText,
    this.isMandatory,
    this.displayType,

    // Answer-specific
    this.inputMaskPlaceholder,
    this.isCustomerFirstName,
    this.isCustomerLastName,
    this.isCustomerTitle,
    this.isCustomerEmail,
    this.promptCustomAnswer,
    this.inputMask,
    this.dateConstraint,
    this.defaultValue,
    this.responseClass,
    this.referenceIdentifier,
    this.score,

    // Question-specific
    this.pick,
    this.correctAnswerId,
    this.facebookProfile,
    this.twitterProfile,
    this.imageUrl,
    this.coverImageUrl,
    this.coverImageOpacity,
    this.coverBackgroundColor,
    this.isShareableOnFacebook,
    this.isShareableOnTwitter,
    this.fontFace,
    this.fontSize,
    this.tagList,
  });

  factory SurveyDetailsItemAttributes.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsItemAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsItemAttributesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SurveyDetailsItemRelationships {
  final SurveyDetailsRelationshipDataList? answers;

  SurveyDetailsItemRelationships({this.answers});

  factory SurveyDetailsItemRelationships.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsItemRelationshipsFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailsItemRelationshipsToJson(this);
}
