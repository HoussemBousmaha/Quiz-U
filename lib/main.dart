import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/firebase_options.dart';
import 'package:quiz_u/ui/screens/home_screen.dart';
import 'package:quiz_u/ui/screens/login_screen.dart';
import 'package:quiz_u/ui/screens/profile_screen.dart';
import 'package:quiz_u/ui/screens/user_name_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: QuizApp()));
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        inputDecorationTheme: const InputDecorationTheme(focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextFeildFillColor, width: 2))),
      ),
      home: const Wrapper(),
      routes: {
        kHomeScreenRoute: (context) => const HomeScreen(),
        kLoginScreenRoute: (context) => const LoginScreen(),
        kUserNameScreenRoute: (context) => const UserNameScreen(),
        kProfileScreenRoute: (context) => const ProfileScreen(),
      },
    );
  }
}

class Wrapper extends HookConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void gotoHomeScreen() => Navigator.of(context).pushNamedAndRemoveUntil(kHomeScreenRoute, (route) => false);

    useAsyncEffect(() async {
      final isTokenValid = await ref.read(authProvider).verifyTokenOnAppLunch();
      if (isTokenValid) gotoHomeScreen();

      return null;
    }, []);

    return const LoginScreen();
  }
}
