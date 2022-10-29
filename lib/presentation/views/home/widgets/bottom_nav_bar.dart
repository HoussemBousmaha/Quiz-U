import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../../../core/resources/color_manager.dart';

class BottomNavBar extends HookConsumerWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: ColorManager.primaryButtonColor),
      child: BottomNavigationBar(
        currentIndex: ref.watch(navBarIndexProvider),
        onTap: (index) => ref.read(navBarIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), label: 'LeaderBoard'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Person'),
        ],
      ),
    );
  }
}
