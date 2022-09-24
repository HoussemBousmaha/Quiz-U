import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/screens/home_screen.dart';
import 'package:quiz_u/ui/screens/profile_screen.dart';
import 'package:quiz_u/ui/screens/quiz_screen.dart';
import 'package:quiz_u/ui/widgets/bottom_nav_bar.dart';

class HomeWrapper extends HookConsumerWidget {
  const HomeWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const screens = [
      HomeScreen(),
      Scaffold(backgroundColor: kAppBackgroundColor),
      ProfileScreen(),
      QuizScreen(),
    ];
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: screens[ref.watch(screenIndexProvider)],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}