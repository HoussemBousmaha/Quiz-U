import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../controllers/providers.dart';
import '../../size_config.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeWrapper extends HookConsumerWidget {
  const HomeWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    const screens = [HomeScreen(), LeaderBoardScreen(), ProfileScreen()];
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
