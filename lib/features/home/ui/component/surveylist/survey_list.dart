import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_background_image.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_item.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/survey_list_view_model.dart';

import '../../../../../gen/assets.gen.dart';

class SurveyList extends ConsumerStatefulWidget {
  const SurveyList({super.key});

  @override
  SurveyListState createState() => SurveyListState();
}

class SurveyListState extends ConsumerState<SurveyList> {
  SurveyListState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(surveyListViewModelProvider.notifier).initialLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<SurveyData> surveyList = ref.watch(surveyListViewModelProvider).surveyList;
    final isLoading = ref.watch(surveyListViewModelProvider).isLoading;

    if (surveyList.isEmpty) {
      return Stack(
        children: [
          Positioned.fill(child: Assets.images.bgOnboarding.image(fit: BoxFit.cover)),
          Positioned.fill(child: Center(child: CircularProgressIndicator())),
        ],
      );
    }

    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: surveyList.length,
      controller: PageController(viewportFraction: 1.0),
      onPageChanged: (index) {
        if (index >= surveyList.length - 1) {
          Future.microtask(() async {
            await ref.watch(surveyListViewModelProvider.notifier).loadMore();
          });
        }
      },
      itemBuilder: (context, index) {
        SurveyData? currentSurvey = surveyList.elementAt(index);
        return Stack(
          children: [
            SurveyBackgroundImage(imageUrl: currentSurvey.attributes?.coverImageUrl ?? ''),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimension.paddingMedium),
                child: SurveyItem(survey: currentSurvey),
              ),
            ),
            isLoading ? Positioned.fill(child: Center(child: CircularProgressIndicator())) : Container(),
          ],
        );
      },
    );
  }
}
