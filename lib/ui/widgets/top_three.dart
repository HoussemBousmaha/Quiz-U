import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../size_config.dart';
import 'leaderboard_circle_avatar.dart';

class TopThree extends HookConsumerWidget {
  const TopThree({Key? key, required this.topScores}) : super(key: key);

  final List<dynamic>? topScores;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: SizeConfig.width(240),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: LeaderBoardCircleAvatar(
              name: topScores?[0]['name'],
              score: topScores?[0]['score'],
              rank: 1,
            ),
          ),
          Positioned(
            top: SizeConfig.height(60),
            left: SizeConfig.width(30),
            child: LeaderBoardCircleAvatar(
              name: topScores?[1]['name'],
              score: topScores?[1]['score'],
              rank: 2,
            ),
          ),
          Positioned(
            top: SizeConfig.height(60),
            right: SizeConfig.width(30),
            child: LeaderBoardCircleAvatar(
              name: topScores?[2]['name'],
              score: topScores?[2]['score'],
              rank: 3,
            ),
          ),
        ],
      ),
    );
  }
}
