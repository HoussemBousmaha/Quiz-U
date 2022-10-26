import 'package:flutter/material.dart';
import 'package:quiz_u_final/core/dependecy_injection/dependency_injection.dart';

import 'core/app/app.dart';
import 'core/app/app.locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  await initAppModule();

  runApp(QuizUApp());
}
