import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nimble_survey_app/core/utils/error_wrapper.dart';
import 'package:nimble_survey_app/features/home/model/home_ui_model.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/home_view_model.dart';
import 'package:nimble_survey_app/l10n/app_localizations.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import 'component/content/home_drawer.dart';

class HomeContent extends ConsumerWidget {
  final HomeUiModel? uiModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeContent({required this.uiModel, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeUiModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: HomeDrawer(
        uiModel: uiModel,
        onLogout: () async {
          final result =
              await ref.read(homeViewModelProvider.notifier).logout();

          if (!context.mounted) return;

          if (result is Success) {
            context.go('/auth');
          } else {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context)?.homeLogoutFailed ?? "",
            );
          }
        },
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Assets.images.bgOnboarding.image(fit: BoxFit.cover),
          ),

          homeUiModel.value == null
              ? Text("no data")
              : Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        uiModel?.user?.name ?? "Name not available",
                        style: TextStyle(color: ColorName.primaryText),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Text('open drawer'),
                      ),
                    ],
                  ),
                ),
              ),
          if (uiModel?.isLoggingOut ?? false) ...[
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
