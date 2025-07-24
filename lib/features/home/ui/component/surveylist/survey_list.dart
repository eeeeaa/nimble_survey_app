import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_background_image.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_item.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/survey_list_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../gen/assets.gen.dart';

class SurveyList extends ConsumerStatefulWidget {
  const SurveyList({super.key});

  @override
  SurveyListState createState() => SurveyListState();
}

class SurveyListState extends ConsumerState<SurveyList> {
  final PageController _controller = PageController(viewportFraction: 1.0);
  Offset? _screenDragStart;

  SurveyListState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isFirstLoad = ref.read(surveyListViewModelProvider).isFirstLoad;
      if (mounted && isFirstLoad) {
        ref.read(surveyListViewModelProvider.notifier).initialLoad();
      }

      if (ref.read(surveyListViewModelProvider).currentIndex > 0) {
        _controller.jumpToPage(
          ref.read(surveyListViewModelProvider).currentIndex,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _createSurveyContent({
    required double bottomScreenRatio,
    required List<SurveyModel> surveyList,
  }) {
    final currentIndex = ref.watch(surveyListViewModelProvider).currentIndex;
    return SizedBox(
      height: bottomScreenRatio,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: surveyList.length,
        controller: _controller,
        onPageChanged: (index) {
          ref
              .watch(surveyListViewModelProvider.notifier)
              .updateCurrentIndex(index);
          if (index >= surveyList.length - 1) {
            ref.read(surveyListViewModelProvider.notifier).loadMore();
          }
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: AppDimension.paddingMedium,
              right: AppDimension.paddingMedium,
            ),
            child: SurveyItem(
              survey: surveyList[currentIndex],
              controller: _controller,
              listLength: surveyList.length,
            ),
          );
        },
      ),
    );
  }

  Widget _createPageIndicator({required List<SurveyModel> surveyList}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimension.spacingSmall,
        bottom: AppDimension.spacingSmall,
        left: AppDimension.paddingMedium,
        right: AppDimension.paddingMedium,
      ),
      child: SmoothPageIndicator(
        controller: _controller,
        count: surveyList.length,
        effect: ScrollingDotsEffect(
          dotHeight: AppDimension.dotIndicatorSize,
          dotWidth: AppDimension.dotIndicatorSize,
          activeDotColor: Colors.white,
        ),
        onDotClicked: (index) {
          _controller.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<SurveyModel> surveyList =
        ref.watch(surveyListViewModelProvider).surveyList;
    final isLoading = ref.watch(surveyListViewModelProvider).isLoading;
    final bottomScreenRatio = MediaQuery.of(context).size.height / 6;
    final currentIndex = ref.watch(surveyListViewModelProvider).currentIndex;

    if (surveyList.isEmpty) {
      return Stack(
        children: [
          Positioned.fill(
            child: Assets.images.bgOnboarding.image(fit: BoxFit.cover),
          ),
          isLoading
              ? Positioned.fill(
                child: Center(child: CircularProgressIndicator()),
              )
              : Positioned.fill(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: AppDimension.profileMediumIconDiameter / 2,
                    child: Icon(
                      Icons.no_accounts_rounded,
                      color: Colors.white,
                      size: AppDimension.profileMediumIconDiameter,
                    ),
                  ),
                ),
              ),
        ],
      );
    }

    return GestureDetector(
      onHorizontalDragStart: (details) {
        _screenDragStart = details.globalPosition;
      },
      onHorizontalDragUpdate: (details) {
        final dragDistance =
            details.globalPosition.dx - (_screenDragStart?.dx ?? 0);
        _controller.position.moveTo(_controller.position.pixels - dragDistance);
        _screenDragStart = details.globalPosition;
      },
      onHorizontalDragEnd: (_) {
        _screenDragStart = null;
      },
      child: Stack(
        children: [
          SurveyBackgroundImage(
            imageUrl: surveyList[currentIndex].coverImageUrl ?? '',
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              _createPageIndicator(surveyList: surveyList),
              _createSurveyContent(
                bottomScreenRatio: bottomScreenRatio,
                surveyList: surveyList,
              ),
            ],
          ),
          isLoading
              ? Positioned.fill(
                child: Center(child: CircularProgressIndicator()),
              )
              : Container(),
        ],
      ),
    );
  }
}
