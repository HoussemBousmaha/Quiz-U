import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final secondDescriptineHeader = Text(
      'Answer as much questions\ncorrectly within 2 minutes',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kPrimaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.width(20),
      ),
    );
    final firstDescriptiveHeader = Text(
      'Ready to test your\nknowledge and challenge\nothers?',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kPrimaryTextColor,
        fontSize: SizeConfig.width(20),
      ),
    );

    void goToQuizScreen() => Navigator.of(context).pushNamed(kQuizScreenRoute);

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizeConfig.addVerticalSpace(120),
                  Text('QuizU', style: kHeadLineTextStyle),
                  SizeConfig.addVerticalSpace(100),
                  firstDescriptiveHeader,
                  SizeConfig.addVerticalSpace(50),
                  CustomButton(
                    'Quiz Me!',
                    width: SizeConfig.size!.width * .5,
                    borderRadius: 4,
                    onPressed: () => goToQuizScreen(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: SizeConfig.width(20),
                    ),
                  ),
                  SizeConfig.addVerticalSpace(50),
                  secondDescriptineHeader,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
