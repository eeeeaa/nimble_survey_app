import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimble_survey_app/features/home/ui/home_content.dart';
import 'package:nimble_survey_app/features/home/ui/home_loading.dart';
import 'package:nimble_survey_app/features/home/ui/viewmodel/home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.watch(homeViewModelProvider.notifier).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeUiModel = ref.watch(homeViewModelProvider);

    return homeUiModel.isContentLoading ? HomeLoading() : HomeContent(uiModel: homeUiModel);
  }
}
