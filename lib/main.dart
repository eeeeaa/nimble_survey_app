import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'main/my_app.dart';

void main() async {
  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.$environment');
  runApp(const MyApp());
}
