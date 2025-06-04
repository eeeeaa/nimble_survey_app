import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import 'loginform/login_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Assets.images.bgOnboarding.image(fit: BoxFit.cover),
          ),

          // Blurred overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              // Adjust blur strength
              child: Container(color: Colors.black.withAlpha(80)),
            ),
          ),

          Positioned.fill(
            child: SafeArea(child: SingleChildScrollView(child: LoginForm())),
          ),
        ],
      ),
    );
  }
}
