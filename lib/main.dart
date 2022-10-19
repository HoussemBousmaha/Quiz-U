import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants.dart';
import 'ui/screens/auth_wrapper.dart';
import 'ui/screens/confirm_otp_screen.dart';
import 'ui/screens/home_wrapper.dart';
import 'ui/screens/quiz_screen.dart';
import 'ui/screens/user_name_screen.dart';

void main() async {
  runApp(const ProviderScope(child: QuizApp()));
}

class QuizApp extends HookConsumerWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kAppBackgroundColor,
        fontFamily: GoogleFonts.comicNeue().fontFamily,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kTextFeildFillColor, width: 2),
          ),
        ),
      ),
      home: const AuthWrapper(),
      routes: {
        kUserNameScreenRoute: (context) => const UserNameScreen(),
        kConfirmOtpScreenRoute: (context) => const ConfirmOTPScreen(),
        kAuthWrapperRoute: (context) => const AuthWrapper(),
        kHomeWrapperRoute: (context) => const HomeWrapper(),
        kQuizScreenRoute: (context) => const QuizScreen(),
      },
    );
  }
}
