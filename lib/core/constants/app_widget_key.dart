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
  static const surveyItemNavigateToDetailsButton = ValueKey(
    "SurveyItemNavigateToDetailsButton",
  );

  // Survey details keys
  static const surveyDetailsScreen = ValueKey("SurveyDetailsScreen");
  static const surveyDetailsTitle = ValueKey("SurveyDetailsTitle");
  static const surveyDetailsDescription = ValueKey("SurveyDetailsDescription");
  static const surveyDetailsStartSurveyButton = ValueKey(
    "SurveyDetailsStartSurveyButton",
  );

  // Question list keys
  static const questionListScreen = ValueKey("QuestionListScreen");
  static const questionListSubmitSurveyButton = ValueKey(
    "QuestionListSubmitSurveyButton",
  );
  static const questionListNavigateBackButton = ValueKey(
    "QuestionListNavigateBackButton",
  );

  // Exit survey dialog
  static const questionListExitSurveyTitle = ValueKey(
    "QuestionListExitSurveyTitle",
  );
  static const questionListExitSurveyDescription = ValueKey(
    "QuestionListExitSurveyDescription",
  );
  static const questionListExitSurveyPositiveButton = ValueKey(
    "QuestionListExitSurveyPositiveButton",
  );
  static const questionListExitSurveyNegativeButton = ValueKey(
    "QuestionListExitSurveyNegativeButton",
  );

  // Survey completed screen
  static const surveyCompletedScreen = ValueKey("SurveyCompletedScreen");
}
