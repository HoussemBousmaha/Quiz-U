import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../presentation/views/confirm_otp/confirm_otp.dart';
import '../../presentation/views/update_user_name/update_user_name.dart';
import '../../presentation/views/home/home.dart';
import '../../presentation/views/login/login.dart';
import '../../presentation/views/splash/splash.dart';
import '../resources/theme_manager.dart';
import 'app.router.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ConfirmOtpView),
    MaterialRoute(page: UpdateUserNameView),
    MaterialRoute(page: LoginView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class QuizUApp extends StatefulWidget {
  // singleton pattern
  const QuizUApp._internal();

  factory QuizUApp() => const QuizUApp._internal();

  @override
  State<QuizUApp> createState() => _QuizUAppState();
}

class _QuizUAppState extends State<QuizUApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}
