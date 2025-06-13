import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/features/home/ui/home_content.dart';
import 'package:nimble_survey_app/features/home/ui/home_loading.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/home_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeUiModel = ref.watch(homeViewModelProvider);

    return homeUiModel.isLoading
        ? HomeLoading()
        : HomeContent(uiModel: homeUiModel.value);
  }
}
