import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/widgets/custom_timer.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final questionsAsyncValue = ref.watch(fetchQuestionsProvider);
    final currentQuestionIndexNotifier = useState<int>(0);

    return questionsAsyncValue.when(
      data: (questions) {
        return Scaffold(
          backgroundColor: kAppBackgroundColor,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const CustomTimer(),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * .8,
                  height: size.height * .3,
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
                          height: size.height * .3,
                          width: size.width * .8,
                          decoration: BoxDecoration(
                            color: kTextFeildFillColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            questions[currentQuestionIndexNotifier.value]['Question'],
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
                            'Question ${currentQuestionIndexNotifier.value + 1}',
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
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      childAspectRatio: 140 / 63,
                      crossAxisSpacing: 30,
                    ),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (currentQuestionIndexNotifier.value < 29) {
                            currentQuestionIndexNotifier.value += 1;
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text('${questions[currentQuestionIndexNotifier.value][String.fromCharCode(index + 97)]}'),
                        ),
                      );
                    }),
                    itemCount: 4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Scaffold(),
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
