import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/survey_response.dart';
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
  int _currentIndex = 0;

  SurveyListState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(surveyListViewModelProvider.notifier).initialLoad();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _createSurveyContent({
    required double bottomScreenRatio,
    required List<SurveyData> surveyList,
  }) {
    return SizedBox(
      height: bottomScreenRatio,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: surveyList.length,
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index >= surveyList.length - 1) {
            Future.microtask(() async {
              await ref.watch(surveyListViewModelProvider.notifier).loadMore();
            });
          }
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(AppDimension.paddingMedium),
            child: SurveyItem(
              survey: surveyList[_currentIndex],
              controller: _controller,
              listLength: surveyList.length,
            ),
          );
        },
      ),
    );
  }

  Widget _createPageIndicator({required List<SurveyData> surveyList}) {
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
        effect: WormEffect(
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
    final List<SurveyData> surveyList =
        ref.watch(surveyListViewModelProvider).surveyList;
    final isLoading = ref.watch(surveyListViewModelProvider).isLoading;
    final bottomScreenRatio = MediaQuery.of(context).size.height / 6;

    if (surveyList.isEmpty) {
      return Stack(
        children: [
          Positioned.fill(
            child: Assets.images.bgOnboarding.image(fit: BoxFit.cover),
          ),
          Positioned.fill(child: Center(child: CircularProgressIndicator())),
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
            imageUrl: surveyList[_currentIndex].attributes?.coverImageUrl ?? '',
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
