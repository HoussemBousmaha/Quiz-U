import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/size_config.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';
import 'package:quiz_u/ui/widgets/top_three.dart';

class LeaderBoardScreen extends HookConsumerWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final topScores = ref.watch(topScoresProvider);

    return topScores.when(
      data: (topScores) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizeConfig.addVerticalSpace(120),
                  Text('QuizU', style: kHeadLineTextStyle),
                  SizeConfig.addVerticalSpace(50),
                  Text(
                    'LeaderBoard',
                    style: kHeadLineTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.width(30),
                    ),
                  ),
                  SizeConfig.addVerticalSpace(30),
                  TopThree(topScores: topScores),
                  SizedBox(
                    height: SizeConfig.height(700),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(40),
                        vertical: SizeConfig.height(20),
                      ),
                      itemBuilder: ((context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(20),
                            vertical: SizeConfig.height(8),
                          ),
                          height: SizeConfig.height(65),
                          width: SizeConfig.width(300),
                          decoration: BoxDecoration(
                            color: kTextFeildFillColor,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: SizeConfig.width(25),
                                height: SizeConfig.height(25),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(color: kPrimaryButtonColor, shape: BoxShape.circle),
                                child: Text(
                                  '${index + 4}',
                                  style: TextStyle(
                                    fontSize: SizeConfig.width(10),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: SizeConfig.height(100),
                                width: SizeConfig.width(100),
                                padding: EdgeInsets.all(SizeConfig.height(7)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kTextFeildFillColor,
                                  border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                                ),
                                child: SvgPicture.asset('assets/male.svg'),
                              ),
                              SizedBox(
                                width: SizeConfig.width(100),
                                child: Text(
                                  topScores?[3 + index]['name'],
                                  style: TextStyle(
                                    fontSize: SizeConfig.width(14),
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${topScores?[3 + index]['score']}',
                                style: TextStyle(
                                  fontSize: SizeConfig.width(20),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('$error $stackTrace'))),
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
