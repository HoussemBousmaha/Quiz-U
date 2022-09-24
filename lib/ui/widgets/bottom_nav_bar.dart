import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';

class BottomNavBar extends HookConsumerWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kSecondaryTextFieldBorderColor, width: 2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(screenIndexProvider.notifier).state = 0;
            },
            child: const Icon(Icons.home_outlined, color: kActiveIconColor, size: 30),
          ),
          GestureDetector(
            onTap: () {
              ref.read(screenIndexProvider.notifier).state = 1;
            },
            child: const Icon(Icons.leaderboard_outlined, color: kInactiveIconColor, size: 30),
          ),
          GestureDetector(
            onTap: () {
              ref.read(screenIndexProvider.notifier).state = 2;
            },
            child: const Icon(Icons.person_outlined, color: kInactiveIconColor, size: 30),
          ),
        ],
      ),
    );
  }
}
