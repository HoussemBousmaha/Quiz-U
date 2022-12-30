import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../resources/route_manager.dart';
import '../resources/theme_manager.dart';

class QuizUApp extends HookConsumerWidget {
  const QuizUApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: MaterialApp(
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.getRoute,
      ),
    );
  }
}
