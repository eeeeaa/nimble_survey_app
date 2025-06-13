import 'package:flutter/material.dart';
import 'package:nimble_survey_app/features/home/ui/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: HomeContent());
  }
}
