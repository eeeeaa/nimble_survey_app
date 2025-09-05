import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/model/survey_model.dart';
import 'package:nimble_survey_app/core/ui/theme/app_dimension.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_background_image.dart';
import 'package:nimble_survey_app/features/home/ui/component/surveylist/survey_item.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/survey_list_view_model.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../loading/bottom_loading_content.dart';

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
              .read(surveyListViewModelProvider.notifier)
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

  Widget _createSurveyListContent({required List<SurveyModel> surveyList}) {
    final bottomScreenRatio = MediaQuery.of(context).size.height / 6;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(surveyListViewModelProvider.notifier).refresh();
        _controller.jumpToPage(
          ref.read(surveyListViewModelProvider).currentIndex,
        );
      },
      child: Stack(
        children: [
          ListView(),
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
        ],
      ),
    );
  }

  Widget _createEmptyListContent() {
    return Center(
      child: Text(
        AppLocalizations.of(context)?.homeEmptySurveyList ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _createLoadingListContent() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox.shrink(),
            ),
            BottomLoadingContent(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<SurveyModel> surveyList =
        ref.watch(surveyListViewModelProvider).surveyList;
    final isLoading = ref.watch(surveyListViewModelProvider).isLoading;
    final isFirstLoad = ref.watch(surveyListViewModelProvider).isFirstLoad;
    final currentIndex = ref.watch(surveyListViewModelProvider).currentIndex;

    if (surveyList.isEmpty) {
      if (isFirstLoad) {
        return _createLoadingListContent();
      } else {
        return _createEmptyListContent();
      }
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
            imageUrl: surveyList[currentIndex].coverImageUrl,
          ),
          _createSurveyListContent(surveyList: surveyList),
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
