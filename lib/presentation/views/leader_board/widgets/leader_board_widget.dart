import 'package:flutter/material.dart';

import '../../../../core/resources/value_manager.dart';
import '../../../../domain/entities/scores_model.dart';
import 'score_card.dart';

class LeaderBoardWidget extends StatelessWidget {
  const LeaderBoardWidget(this.scoresModel, {Key? key}) : super(key: key);

  final ScoresModel scoresModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws50, vertical: AppSize.hs20),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            scoresModel.scores.length,
            (index) => ScoreCard(index, scoresModel.scores[index]),
          ),
        ),
      ),
    );
  }
}
