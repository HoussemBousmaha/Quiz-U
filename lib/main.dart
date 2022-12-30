import 'package:flutter/material.dart';

import 'core/app/app.dart';
import 'core/providers/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initModules();
  runApp(const QuizUApp());
}
