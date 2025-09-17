import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/constants/app_widget_key.dart';
import 'package:nimble_survey_app/features/home/model/home_ui_model.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/home_view_model.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import 'component/profile/home_drawer.dart';
import 'component/profile/home_profile_bar.dart';
import 'component/surveylist/survey_list.dart';

class HomeContent extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiModel = ref.watch(homeViewModelProvider);

    ref.listen(homeViewModelProvider, (_, uiModel) {
      uiModel.when((user, isContentLoading, isLoggingOut, isLogOutSuccess) {
        if (isLogOutSuccess == true) {
          context.go('/auth');
        } else if (isLogOutSuccess == false) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)?.homeLogoutFailed ?? "",
          );
        }
      });
    });

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: HomeDrawer(
        uiModel: uiModel,
        onLogout:
            () async => await ref.read(homeViewModelProvider.notifier).logout(),
      ),
      body: Stack(
        key: AppWidgetKey.homeScreen,
        children: [
          Positioned.fill(child: SurveyList()),

          Positioned.fill(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  HomeProfileBar(
                    onProfileClicked: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    uiModel: uiModel,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          if (uiModel.isLoggingOut) ...[
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withValues(alpha: 0.5),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
