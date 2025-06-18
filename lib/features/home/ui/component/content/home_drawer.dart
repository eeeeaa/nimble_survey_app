import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/core/ui/component/loading_circle.dart';

import '../../../../../core/ui/theme/app_dimension.dart';
import '../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../model/home_ui_model.dart';

class HomeDrawer extends ConsumerWidget {
  final HomeUiModel? uiModel;
  final Function onLogout;

  const HomeDrawer({required this.uiModel, required this.onLogout, super.key});

  Widget _header() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: AppDimension.spacingMedium,
        children: [
          Flexible(
            child: Text(
              uiModel?.user?.name ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorName.primaryText,
                fontSize: AppTextSize.textSizeXL,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl: uiModel?.user?.avatar ?? '',
            imageBuilder:
                (context, imageProvider) => CircleAvatar(
                  radius: AppDimension.profileMediumIconDiameter / 2,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.transparent,
                ),
            placeholder:
                (context, url) => CircleAvatar(
                  radius: AppDimension.profileMediumIconDiameter / 2,
                  backgroundColor: Colors.transparent,
                  child: LoadingCircle(
                    radius: AppDimension.profileMediumIconDiameter / 2,
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }

  Widget _logOut({required BuildContext context}) {
    return ListTile(
      title: Text(
        AppLocalizations.of(context)?.homeLogout ?? '',
        style: TextStyle(color: ColorName.primaryText),
      ),
      onTap: () async {
        await onLogout();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Container(
        color: ColorName.bgSideMenu,
        child: ListView(
          padding: EdgeInsets.all(AppDimension.paddingMedium),
          children: [
            _header(),
            Divider(color: Colors.grey.shade700, thickness: 1, height: 1),
            _logOut(context: context),
          ],
        ),
      ),
    );
  }
}
