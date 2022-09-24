import 'package:flutter/material.dart';
import 'package:quiz_u/constants.dart';

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
      height: 285,
      width: 325,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 20,
            bottom: 15,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: kTextFeildFillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 35,
              width: 115,
              decoration: BoxDecoration(
                color: kAppBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kTextFeildFillColor, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                'Question ${questionNumber + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: kPrimaryTextColor),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(color: kAppBackgroundColor, shape: BoxShape.circle),
              child: const Icon(Icons.question_mark_rounded, size: 15),
            ),
          ),
        ],
      ),
    );
  }
}
