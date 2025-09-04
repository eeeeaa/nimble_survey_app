import 'package:flutter/cupertino.dart';

class AppWidgetKey {
  AppWidgetKey._();

  // Splash screen key
  static const splashScreen = ValueKey("SplashScreen");

  // Login form keys
  static const loginEmailTextField = ValueKey("LoginEmailTextField");
  static const loginPasswordTextField = ValueKey("LoginPasswordTextField");
  static const loginResetPasswordButton = ValueKey("LoginResetPasswordButton");
  static const loginSubmitButton = ValueKey("LoginSubmitButton");

  // Home screen
  static const homeScreen = ValueKey("HomeScreen");
}
