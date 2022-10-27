import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u_final/core/resources/font_manager.dart';

import '../../../core/dependecy_injection/dependency_injection.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../../../domain/entities/score_model.dart';
import '../../../domain/entities/scores_model.dart';
import '../common/state_renderer/state_renderer_implementer.dart';
import 'leader_board_view_model.dart';

class LeaderBoardView extends StatefulHookConsumerWidget {
  const LeaderBoardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends ConsumerState<LeaderBoardView> {
  late final LeaderBoardViewModel model;

  @override
  void initState() {
    model = instance<LeaderBoardViewModel>();
    model.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: model.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _getContentWidget()) ?? _getContentWidget();
      },
    );
  }

  Scaffold _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: StreamBuilder<ScoresModel>(
        stream: model.scoresStreamController.stream,
        builder: (context, snapshot) {
          final scores = snapshot.data?.scores;
          if (scores == null) return const SizedBox.shrink();
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: AppSize.ws50, vertical: AppSize.hs20),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(scores.length, (index) => _getScoreCard(index, scores[index])),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getScoreCard(int index, ScoreModel score) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: ColorManager.primaryButtonColor.withOpacity(.2),
        highlightColor: ColorManager.backgroundColor.withOpacity(.5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: AppSize.ws30),
        focusColor: ColorManager.primaryButtonColor,
        hoverColor: ColorManager.primaryButtonColor,
        onTap: () {},
        leading: Text(
          '${index + 1}',
          style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black, fontSize: FontSize.s16),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              index % 2 == 0 ? FontAwesomeIcons.person : FontAwesomeIcons.personDress,
              color: ColorManager.primaryButtonColor,
            ),
            SizedBox(width: AppSize.ws30),
            Text(
              score.name,
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: ColorManager.primaryButtonColor,
                    fontSize: FontSize.s15,
                  ),
            ),
          ],
        ),
        trailing: Text(
          score.score.toString(),
          style: Theme.of(context).textTheme.headline2?.copyWith(
                color: Colors.black,
                fontSize: FontSize.s19,
              ),
        ),
      ),
    );
  }
}
