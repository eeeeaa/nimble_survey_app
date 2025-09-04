import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> setUpIntegrationTesting() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await dotenv.load(fileName: '.env.$environment');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
}
