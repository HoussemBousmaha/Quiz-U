import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/ui/screens/home_screen.dart';

class HomeWrapper extends HookConsumerWidget {
  const HomeWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: const HomeScreen(),
      bottomNavigationBar: Container(),
    );
  }
}
