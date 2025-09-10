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

  // Reset password keys
  static const resetPasswordLogo = ValueKey("resetPasswordLogo");
  static const resetPasswordDescription = ValueKey("ResetPasswordDescription");
  static const resetPasswordEmailTextField = ValueKey(
    "resetPasswordEmailTextField",
  );
  static const resetPasswordSubmitButton = ValueKey(
    "resetPasswordSubmitButton",
  );

  // Home screen keys
  static const homeScreen = ValueKey("HomeScreen");
  static const homeProfileBar = ValueKey("HomeProfileBar");
  static const homeProfileAvatar = ValueKey("HomeProfileAvatar");
  static const homeDrawer = ValueKey("HomeDrawer");
  static const homeDrawerProfileName = ValueKey(("HomeDrawerProfileName"));
  static const homeDrawerProfileAvatar = ValueKey("HomeDrawerProfileAvatar");
  static const homeDrawerLogout = ValueKey("HomeDrawerLogout");
}
