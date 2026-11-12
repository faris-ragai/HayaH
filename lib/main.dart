import 'package:flutter/material.dart';
import 'screens/my_app.dart';
import 'service/app_startup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}
