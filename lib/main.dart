import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main/my_app.dart';

void main() async {
  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.$environment');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(child: MyApp()));
}
