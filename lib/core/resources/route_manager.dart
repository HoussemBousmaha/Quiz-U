import 'package:flutter/material.dart';

import '../../presentation/views/confirm_otp/confirm_otp.dart';
import '../../presentation/views/home/home.dart';
import '../../presentation/views/leader_board/leader_board.dart';
import '../../presentation/views/login/login.dart';
import '../../presentation/views/splash/splash.dart';
import '../../presentation/views/update_user_name/update_user_name.dart';

class Routes {
  static const splashRoute = '/';
  static const loginRoute = '/login';
  static const homeRoute = '/home';
  static const confirmOtpRoute = '/confirmOtp';
  static const leaderBoardRoute = '/leaderBoard';
  static const updateUserNameRoute = '/updateUserName';
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.confirmOtpRoute:
        return MaterialPageRoute(builder: (_) => const ConfirmOtpView());
      case Routes.leaderBoardRoute:
        return MaterialPageRoute(builder: (_) => const LeaderBoardView());
      case Routes.updateUserNameRoute:
        return MaterialPageRoute(builder: (_) => const UpdateUserNameView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
