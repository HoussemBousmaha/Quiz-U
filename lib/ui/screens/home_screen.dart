import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/logo.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const secondDescriptineHeader = Text(
      'Answer as much questions\ncorrectly within 2 minutes',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kPrimaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
    const firstDescriptiveHeader = Text(
      'Ready to test your\nknowledge and challenge\nothers?',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: kPrimaryTextColor,
      ),
    );

    final size = MediaQuery.of(context).size;

    void goToQuizScreen() => Navigator.of(context).pushNamed(kQuizScreenRoute);

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 100),
                firstDescriptiveHeader,
                const SizedBox(height: 50),
                CustomButton(
                  'Quiz Me!',
                  width: size.width * 0.5,
                  borderRadius: 4,
                  onPressed: () => goToQuizScreen(),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 50),
                secondDescriptineHeader,
              ],
            ),
          ),
          const Logo(),
        ],
      ),
    );
  }
}
