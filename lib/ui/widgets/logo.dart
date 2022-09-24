import 'package:flutter/material.dart';
import 'package:quiz_u/constants.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 140,
      child: Text('QuizU', style: kHeadLineTextStyle),
    );
  }
}
