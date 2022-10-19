import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../constants.dart';
import '../../controllers/providers.dart';
import '../../size_config.dart';

class UserScoresListView extends HookConsumerWidget {
  const UserScoresListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userScores = ref.watch(userScoresProvider);
    return userScores.when(
      data: (scores) {
        return SizedBox(
          height: 150,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizeConfig.addVerticalSpace(20),
            padding: EdgeInsets.only(bottom: SizeConfig.height(20)),
            itemCount: scores.length,
            itemBuilder: (context, index) {
              return Container(
                height: 55,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 45),
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
                      style: TextStyle(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.width(15),
                      ),
                    ),
                    Text(
                      '${scores[index].score}',
                      style: TextStyle(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.width(15),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => Text('$error $stackTrace'),
      loading: () => Container(
        height: SizeConfig.height(150),
        width: SizeConfig.height(150),
        alignment: Alignment.center,
        child: const LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          strokeWidth: 5,
          colors: [kPrimaryTextColor],
        ),
      ),
    );
  }
}
