import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';

class UserScoresListView extends HookConsumerWidget {
  const UserScoresListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userScores = ref.watch(userScoresProvider);
    return userScores.when(
      data: (scores) {
        return SizedBox(
          height: 100,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: scores.length,
            itemBuilder: (context, index) {
              return Container(
                height: 55,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: kTextFeildFillColor,
                  border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      scores[index].timeSaved,
                      style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      '${scores[index].score}',
                      style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => Text('$error $stackTrace'),
      loading: () => const SizedBox(
        height: 50,
        width: 50,
        child: LoadingIndicator(indicatorType: Indicator.circleStrokeSpin, strokeWidth: 8, colors: [kPrimaryTextColor]),
      ),
    );
  }
}
