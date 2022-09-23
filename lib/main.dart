import 'dart:developer' as dev;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/ui/screens/home_screen.dart';
import 'package:quiz_u/ui/screens/login_screen.dart';
import 'package:quiz_u/ui/screens/user_name_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: QuizApp()));
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
      routes: {
        homeScreenRoute: (context) => const HomeScreen(),
        loginScreenRoute: (context) => const LoginScreen(),
        userNameScreenRoute: (context) => const UserNameScreen(),
      },
    );
  }
}

class Wrapper extends HookConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future gotoHomeScreen() async {
      await Navigator.of(context).pushReplacementNamed(homeScreenRoute);
    }

    useAsyncEffect(() async {
      ref.read(isLoadingProvider.notifier).state = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        ref.read(isLoadingProvider.notifier).state = false;
        return;
      }

      final isLoggedIn = await ref.read(authProvider).verifyTokenOnAppLunch(token: token);
      if (isLoggedIn) await gotoHomeScreen();
      dev.log(isLoggedIn.toString());
      ref.read(isLoadingProvider.notifier).state = false;

      return null;
    }, []);

    return const LoginScreen();
  }
}
