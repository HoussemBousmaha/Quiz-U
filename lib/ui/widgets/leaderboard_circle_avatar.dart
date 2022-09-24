import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';

class LeaderBoardCircleAvatar extends HookConsumerWidget {
  const LeaderBoardCircleAvatar({
    Key? key,
    required this.name,
    required this.score,
  }) : super(key: key);

  final String name;
  final int score;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text('$score', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const SizedBox(height: 15),
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kTextFeildFillColor,
            border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
          ),
          child: SvgPicture.asset('assets/male.svg'),
        ),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
