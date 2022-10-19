import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.questionNumber,
  }) : super(key: key);

  final String question;
  final int questionNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height(285),
      width: SizeConfig.width(325),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: SizeConfig.height(20),
            bottom: SizeConfig.height(15),
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(40)),
              decoration: BoxDecoration(
                color: kTextFeildFillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.width(22),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: SizeConfig.height(35),
              width: SizeConfig.width(115),
              decoration: BoxDecoration(
                color: kAppBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kTextFeildFillColor, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                'Question ${questionNumber + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.width(12),
                  color: kPrimaryTextColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: SizeConfig.height(30),
              width: SizeConfig.width(30),
              decoration: const BoxDecoration(color: kAppBackgroundColor, shape: BoxShape.circle),
              child: Icon(
                Icons.question_mark_rounded,
                size: SizeConfig.height(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
