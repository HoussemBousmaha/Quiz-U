import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/ui/widgets/leaderboard_circle_avatar.dart';

class TopThree extends HookConsumerWidget {
  const TopThree({Key? key, required this.topScores}) : super(key: key);

  final List<dynamic>? topScores;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: LeaderBoardCircleAvatar(name: topScores?[0]['name'], score: topScores?[0]['score']),
          ),
          Positioned(
            top: 60,
            left: 30,
            child: LeaderBoardCircleAvatar(name: topScores?[1]['name'], score: topScores?[1]['score']),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: LeaderBoardCircleAvatar(name: topScores?[2]['name'], score: topScores?[2]['score']),
          ),
        ],
      ),
    );
  }
}
