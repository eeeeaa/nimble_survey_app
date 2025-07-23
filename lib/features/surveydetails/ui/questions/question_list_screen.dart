import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/model/survey_question_model.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/ui/theme/app_dimension.dart';
import '../../../../core/ui/theme/app_text_size.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../home/ui/component/surveylist/survey_background_image.dart';
import '../../viewmodel/survey_details_view_model.dart';
import '../component/question/question_item.dart';

class QuestionListScreen extends ConsumerStatefulWidget {
  const QuestionListScreen({super.key});

  @override
  QuestionListScreenState createState() => QuestionListScreenState();
}

class QuestionListScreenState extends ConsumerState<QuestionListScreen> {
  final PageController _controller = PageController(viewportFraction: 1.0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _createQuestionItemContent({
    required List<SurveyQuestionModel> questions,
    required int index,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Assets.images.icClose.svg(),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${index + 1}/${questions.length}",
            style: TextStyle(
              color: ColorName.secondaryText,
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(child: QuestionItem(question: questions[index])),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(
                AppDimension.surveyCircleButtonDiameter / 4,
              ),
            ),
            onPressed: () {
              _controller.nextPage(
                duration: const Duration(
                  milliseconds:
                      AppConstants.questionListPageScrollDurationInMilliseconds,
                ),
                curve: Curves.easeIn,
              );
            },
            child: Assets.images.icArrowNext.svg(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        ref
            .watch(surveyDetailsViewModelProvider)
            .surveyDetails
            ?.coverImageUrl ??
        '';
    final questions =
        ref.watch(surveyDetailsViewModelProvider).surveyDetails?.questions ??
        List.empty();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // TODO show dialog
      },
      child: Scaffold(
        body: Stack(
          children: [
            SurveyBackgroundImage(imageUrl: imageUrl),
            // Blurred overlay
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                // Adjust blur strength
                child: Container(color: Colors.black.withAlpha(100)),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: questions.length,
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: AppDimension.paddingMedium,
                        right: AppDimension.paddingMedium,
                      ),
                      child: _createQuestionItemContent(
                        questions: questions,
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
