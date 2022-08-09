import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'db/database_manager.dart';

void main() async {
  // Set up allowed orientations
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
  DeviceOrientation.portraitUp,
  ]);
  await DatabaseManager.initialize();
  runApp(App());
}