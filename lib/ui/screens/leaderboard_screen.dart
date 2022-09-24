import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';
import 'package:quiz_u/ui/widgets/top_three.dart';

class LeaderBoardScreen extends HookConsumerWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topScores = ref.watch(topScoresProvider);

    return topScores.when(
      data: (topScores) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text('QuizU', style: kHeadLineTextStyle),
                const SizedBox(height: 50),
                Text('LeaderBoard', style: kHeadLineTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.w500)),
                const SizedBox(height: 35),
                TopThree(topScores: topScores),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    itemBuilder: ((context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                        height: 60,
                        width: 320,
                        decoration: BoxDecoration(
                          color: kTextFeildFillColor,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Row(
                          children: [
                            Text('${index + 3}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: kTextFeildFillColor, border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2)),
                              child: SvgPicture.asset('assets/male.svg'),
                            ),
                            Text(topScores?[3 + index]['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            const Spacer(),
                            Text('${topScores?[3 + index]['score']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
                          ],
                        ),
                      );
                    }),
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemCount: 7,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('$error $stackTrace'))),
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
