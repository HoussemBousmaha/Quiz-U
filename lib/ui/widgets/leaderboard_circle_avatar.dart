import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/size_config.dart';

class LeaderBoardCircleAvatar extends HookConsumerWidget {
  const LeaderBoardCircleAvatar({
    Key? key,
    required this.name,
    required this.score,
    required this.rank,
  }) : super(key: key);

  final String name;
  final int score;
  final int rank;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          '$score',
          style: TextStyle(fontSize: SizeConfig.width(20), fontWeight: FontWeight.bold),
        ),
        SizeConfig.addVerticalSpace(15),
        SizedBox(
          height: SizeConfig.height(120),
          width: SizeConfig.width(120),
          // alignment: Alignment.center,
          child: Stack(
            alignment: const Alignment(0, -1),
            children: [
              Positioned(
                top: SizeConfig.height(10),
                height: SizeConfig.height(100),
                width: SizeConfig.height(100),
                child: Container(
                  height: SizeConfig.height(100),
                  width: SizeConfig.height(100),
                  padding: EdgeInsets.all(SizeConfig.height(25)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kTextFeildFillColor,
                    border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                  ),
                  child: SvgPicture.asset('assets/male.svg'),
                ),
              ),
              Container(
                width: SizeConfig.width(20),
                height: SizeConfig.height(20),
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: kPrimaryButtonColor, shape: BoxShape.circle),
                child: Text(
                  '$rank',
                  style: TextStyle(
                    fontSize: SizeConfig.width(12),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizeConfig.addVerticalSpace(10),
        Container(
          width: SizeConfig.width(100),
          alignment: Alignment.center,
          child: Text(name, style: TextStyle(fontSize: SizeConfig.width(12), fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
