import 'package:flutter/material.dart';
import 'package:nimble_survey_app/features/home/ui/component/bottom_loading_content.dart';

import 'component/top_loading_content.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: TopShimmerContent(),
            ),
            BottomLoadingContent(),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
