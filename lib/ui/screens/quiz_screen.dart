import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/size_config.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_timer.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';
import 'package:quiz_u/ui/widgets/question_card.dart';
import 'package:quiz_u/ui/widgets/quiz_answers.dart';

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final questionsAsyncValue = ref.watch(fetchQuestionsProvider);

    final screenFadeController = useAnimationController(duration: const Duration(milliseconds: 300), initialValue: 1.0);
    final skipButtonFadeController = useAnimationController(duration: const Duration(milliseconds: 300), initialValue: 1.0);

    final isSkipped = useState<bool>(false);

    useEffect(
      () {
        ref.read(isQuizStartedProvider.notifier).state = true;
        return null;
      },
      [],
    );

    void skipQuestion() async {
      skipButtonFadeController.reverse();
      screenFadeController.reverse(from: .5);
      await Future.delayed(const Duration(milliseconds: 300));

      final questionIndex = ref.watch(questionIndexProvider);

      screenFadeController.forward(from: .5);
      if (questionIndex < 29) ref.read(questionIndexProvider.notifier).state++;
      isSkipped.value = true;
    }

    return questionsAsyncValue.when(
      data: (questions) {
        return Scaffold(
          backgroundColor: kAppBackgroundColor,
          body: FadeTransition(
            opacity: screenFadeController,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizeConfig.addVerticalSpace(100),
                    const CustomTimer(),
                    SizeConfig.addVerticalSpace(50),
                    QuestionCard(question: questions?[ref.watch(questionIndexProvider)]['Question'], questionNumber: ref.watch(questionIndexProvider)),
                    SizeConfig.addVerticalSpace(30),
                    QuizAnswers(questions: questions ?? []),
                    SizeConfig.addVerticalSpace(30),
                    if (isSkipped.value == false)
                      FadeTransition(
                        opacity: skipButtonFadeController,
                        child: CustomButton(
                          'Skip',
                          onPressed: skipQuestion,
                          height: SizeConfig.height(50),
                          width: SizeConfig.width(200),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.width(20),
                          ),
                        ),
                      ),
                    SizeConfig.addVerticalSpace(100),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('$error $stackTrace'))),
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
