import 'package:nimble_survey_app/core/model/survey_answer_model.dart';

import '../model/display_type.dart';
import '../model/survey_details_response.dart';
import '../model/survey_question_model.dart';

/// Maps a [SurveyDetailsResponse] into a list of [SurveyQuestionModel]s.
List<SurveyQuestionModel> mapToQuestionModelList({
  required SurveyDetailsResponse res,
}) {
  final included = res.included ?? [];

  // Create a map from included items using their ID for quick lookup
  final includedMap = {
    for (final item in included)
      if (item.id != null) item.id!: item,
  };

  // Filter out all items that are of type 'question'
  final questionItems = included.where((item) => item.type == 'question');

  // Map each question item to a SurveyQuestionModel
  return questionItems.map((question) {
    // Extract list of answer IDs from the question's relationships
    final answerIds =
        question.relationships?.answers?.data
            ?.map((rel) => rel.id)
            .whereType<String>()
            .toSet() ??
        {};

    // Retrieve answer items from the included map by their IDs
    final answers =
        answerIds
            .map((id) => includedMap[id])
            .whereType<SurveyDetailsIncludedItem>() // Filter out nulls
            .map((answer) {
              final attributes = answer.attributes;
              return SurveyAnswerModel(
                id: answer.id ?? '',
                answerText: attributes?.text ?? '',
                displayOrder:
                    int.tryParse(attributes?.displayOrder?.toString() ?? '') ??
                    0,
              );
            })
            .toList();

    // Construct and return the SurveyQuestionModel
    final attributes = question.attributes;
    return SurveyQuestionModel(
      id: question.id ?? '',
      questionText: attributes?.text ?? '',
      displayType: DisplayTypeExtension.fromString(
        attributes?.displayType ?? '',
      ),
      maxChoice: int.tryParse(attributes?.pick?.toString() ?? '') ?? 1,
      answers: answers,
    );
  }).toList();
}
