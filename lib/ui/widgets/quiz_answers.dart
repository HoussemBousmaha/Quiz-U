import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../controllers/providers.dart';
import '../../size_config.dart';

class QuizAnswers extends HookConsumerWidget {
  const QuizAnswers({
    Key? key,
    required this.questions,
  }) : super(key: key);

  final List questions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionIndex = ref.watch(questionIndexProvider);
    final answers = [
      questions[questionIndex]['a'],
      questions[questionIndex]['b'],
      questions[questionIndex]['c'],
      questions[questionIndex]['d']
    ];

    final correctAnswer = questions[questionIndex][questions[questionIndex]['correct']];

    Future<void> showTryAgainDialog() async {
      await showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: kAppBackgroundColor,
            title: const Center(
              child: Text('You lost!', style: TextStyle(color: kPrimaryTextColor)),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryButtonColor),
                  onPressed: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(kAuthWrapperRoute, ((route) => false));
                  },
                  child: const Text(
                    'Try Again',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    }

    Future<void> submitAnswer(int index) async {
      final isSubmitted = ref.watch(isAnswerSubmittedProvider);
      final correctAnswerIndex = answers.indexWhere((answer) => answer == correctAnswer);

      if (isSubmitted[index] == false) {
        ref.read(isAnswerSubmittedProvider.notifier).state =
            List.generate(4, (i) => index == i || correctAnswerIndex == i);
        ref.read(isCorrectAnswersListProvider.notifier).state =
            List.generate(4, (index) => answers[index] == correctAnswer);
        final isCorrect = ref.watch(isCorrectAnswersListProvider);

        await Future.delayed(const Duration(milliseconds: 300));

        if (isCorrect[index] && questionIndex < 29) {
          ref.read(questionIndexProvider.notifier).state++;
        } else if (!isCorrect[index]) {
          await showTryAgainDialog();
        }

        ref.refresh(isAnswerSubmittedProvider);
        ref.refresh(isCorrectAnswersListProvider);
      }
    }

    return SizedBox(
      height: SizeConfig.height(170),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(35), vertical: SizeConfig.height(15)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: SizeConfig.width(140) / SizeConfig.height(65),
          crossAxisSpacing: SizeConfig.width(30),
          mainAxisSpacing: SizeConfig.width(15),
        ),
        itemCount: 4,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () => submitAnswer(index),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ref.watch(isAnswerSubmittedProvider)[index]
                    ? ref.watch(isCorrectAnswersListProvider)[index]
                        ? kSuccessGreenColor
                        : kErrorRedColor
                    : Colors.white,
                border: Border.all(color: kTextFeildFillColor, width: 3),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                answers[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.width(16),
                  color: ref.watch(isAnswerSubmittedProvider)[index] ? Colors.white : kPrimaryTextColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
