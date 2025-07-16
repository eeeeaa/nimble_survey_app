import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nimble_survey_app/core/utils/date_helper.dart';
import 'package:nimble_survey_app/core/utils/uri_helper.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../../../core/ui/component/loading_circle.dart';
import '../../../../../core/ui/theme/app_dimension.dart';
import '../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../model/home_ui_model.dart';

class HomeProfileBar extends StatelessWidget {
  final HomeUiModel? uiModel;
  final VoidCallback onProfileClicked;

  const HomeProfileBar({
    required this.onProfileClicked,
    required this.uiModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.directional(
        start: AppDimension.paddingLarge,
        end: AppDimension.paddingLarge,
        top: AppDimension.paddingMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getCurrentDateDisplay(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorName.primaryText,
                    fontSize: AppTextSize.textSizeExtraSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.homeToday ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorName.primaryText,
                    fontSize: AppTextSize.textSizeXXL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          isValidUrl(uiModel?.user?.avatar)
              ? CachedNetworkImage(
                imageUrl: uiModel?.user?.avatar ?? '',
                imageBuilder:
                    (context, imageProvider) => InkWell(
                      onTap: () {
                        onProfileClicked();
                      },
                      child: CircleAvatar(
                        radius: AppDimension.profileMediumIconDiameter / 2,
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                placeholder:
                    (context, url) => CircleAvatar(
                      radius: AppDimension.profileMediumIconDiameter / 2,
                      backgroundColor: Colors.transparent,
                      child: LoadingCircle(
                        radius: AppDimension.profileMediumIconDiameter / 2,
                      ),
                    ),
                errorWidget:
                    (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: AppDimension.profileMediumIconDiameter / 2,
                      child: Icon(
                        Icons.no_accounts_rounded,
                        color: Colors.white,
                        size: AppDimension.profileMediumIconDiameter,
                      ),
                    ),
              )
              : CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: AppDimension.profileMediumIconDiameter / 2,
                child: Icon(
                  Icons.no_accounts_rounded,
                  color: Colors.white,
                  size: AppDimension.profileMediumIconDiameter,
                ),
              ),
        ],
      ),
    );
  }
}
