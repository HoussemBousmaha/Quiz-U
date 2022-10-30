import 'package:flutter/material.dart';

import '../resources/route_manager.dart';
import '../resources/theme_manager.dart';

class QuizUApp extends StatefulWidget {
  const QuizUApp._internal();

  factory QuizUApp() => const QuizUApp._internal();

  @override
  State<QuizUApp> createState() => _QuizUAppState();
}

class _QuizUAppState extends State<QuizUApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.getRoute,
    );
  }
}
