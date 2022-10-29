import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../common/flow_state.dart';
import 'leader_board_vm.dart';
import 'widgets/leader_board_widget.dart';

class LeaderBoardView extends StatefulHookConsumerWidget {
  const LeaderBoardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends ConsumerState<LeaderBoardView> {
  late final LeaderBoardViewModel model;

  @override
  void initState() {
    model = ref.read(leaderboardViewModelProvider);
    model.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(flowStateStreamProvider);

    return Scaffold(
      body: flowState.whenOrNull(data: (flowState) => flowState.getView(context, _getContentWidget())),
    );
  }

  Widget _getContentWidget() {
    final scoresModel = ref.watch(scoresModelStreamProvider);
    return Scaffold(
      body: scoresModel.whenOrNull(data: (scoresModel) => LeaderBoardWidget(scoresModel)),
    );
  }
}
