import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/constants/app_widget_key.dart';

import '../../../core/model/survey_details_model.dart';
import '../../../core/ui/component/nimble_button.dart';
import '../../../core/ui/theme/app_dimension.dart';
import '../../../core/ui/theme/app_text_size.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/ui/component/surveylist/survey_background_image.dart';
import '../model/survey_details_ui_model.dart';
import '../viewmodel/survey_details_view_model.dart';

class SurveyDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const SurveyDetailsScreen({required this.id, super.key});

  @override
  SurveyDetailsScreenState createState() => SurveyDetailsScreenState();
}

class SurveyDetailsScreenState extends ConsumerState<SurveyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref
            .read(surveyDetailsViewModelProvider.notifier)
            .initialLoad(id: widget.id);
      }
    });
  }

  Widget _createSurveyDetailsHeader({required SurveyDetailsModel survey}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimension.paddingMedium),
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Assets.images.icArrowBack.svg(),
          ),
        ),
        Text(
          key: AppWidgetKey.surveyDetailsTitle,
          survey.title,
          style: TextStyle(
            color: ColorName.primaryText,
            fontSize: AppTextSize.textSizeXXL,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          key: AppWidgetKey.surveyDetailsDescription,
          survey.description,
          style: TextStyle(
            color: ColorName.secondaryText,
            fontSize: AppTextSize.textSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SurveyDetailsUiModel uiModel = ref.watch(
      surveyDetailsViewModelProvider,
    );
    final SurveyDetailsModel? survey = uiModel.surveyDetails;

    if (survey == null) {
      // TODO replace with error screen
      return Stack(
        children: [
          SurveyBackgroundImage(imageUrl: ''),
          uiModel.isLoading
              ? Positioned.fill(
                child: Center(child: CircularProgressIndicator()),
              )
              : Positioned.fill(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: AppDimension.profileMediumIconDiameter / 2,
                    child: Icon(
                      Icons.no_backpack,
                      color: Colors.white,
                      size: AppDimension.profileMediumIconDiameter,
                    ),
                  ),
                ),
              ),
        ],
      );
    }
    return Scaffold(
      key: AppWidgetKey.surveyDetailsScreen,
      body: Stack(
        children: [
          SurveyBackgroundImage(imageUrl: survey.coverImageUrl),
          // Blurred overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              // Adjust blur strength
              child: Container(color: Colors.black.withAlpha(80)),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimension.paddingMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _createSurveyDetailsHeader(survey: survey),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: NimbleButton(
                        key: AppWidgetKey.surveyDetailsStartSurveyButton,
                        width: null,
                        buttonText:
                            AppLocalizations.of(
                              context,
                            )?.surveyDetailStartSurvey ??
                            '',
                        onPressed: () {
                          context.push('/survey/${survey.id}/survey-sessions');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
