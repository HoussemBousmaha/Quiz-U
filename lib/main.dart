import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:quiz_u/constants.dart';
import 'package:quiz_u/firebase_options.dart';
import 'package:quiz_u/ui/screens/auth_wrapper.dart';
import 'package:quiz_u/ui/screens/confirm_otp_screen.dart';
import 'package:quiz_u/ui/screens/home_screen.dart';
import 'package:quiz_u/ui/screens/home_wrapper.dart';
import 'package:quiz_u/ui/screens/login_screen.dart';
import 'package:quiz_u/ui/screens/profile_screen.dart';
import 'package:quiz_u/ui/screens/quiz_screen.dart';
import 'package:quiz_u/ui/screens/user_name_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: QuizApp()));
}

class QuizApp extends HookConsumerWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        inputDecorationTheme: const InputDecorationTheme(focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextFeildFillColor, width: 2))),
      ),
      home: const AuthWrapper(),
      routes: {
        kHomeScreenRoute: (context) => const HomeScreen(),
        kLoginScreenRoute: (context) => const LoginScreen(),
        kUserNameScreenRoute: (context) => const UserNameScreen(),
        kProfileScreenRoute: (context) => const ProfileScreen(),
        kConfirmOtpScreenRoute: (context) => const ConfirmOTPScreen(),
        kAuthWrapperRoute: (context) => const AuthWrapper(),
        kHomeWrapperRoute: (context) => const HomeWrapper(),
        kQuizScreenRoute: (context) => const QuizScreen(),
      },
    );
  }
}
