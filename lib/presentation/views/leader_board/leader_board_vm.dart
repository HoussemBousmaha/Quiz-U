import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../domain/usecases/get_top_scores_usecase.dart';
import '../base/base_view_model.dart';
import '../common/flow_state.dart';
import '../common/flow_state_view.dart';

class LeaderBoardViewModel extends BaseViewModel {
  final TopScoresUseCase _topScoresUseCase;
  final ProviderRef _ref;

  LeaderBoardViewModel(this._ref) : _topScoresUseCase = _ref.read(topScoresUseCaseProvider);

  @override
  void start() async => await getTopScores();

  @override
  void dispose() {}

  Future<void> getTopScores() async {
    _ref.read(flowStateStreamController).sink.add(LoadingState(StateType.fullScreenLoading, 'Loading...'));

    (await _topScoresUseCase.execute(null)).fold(
      (failure) => _ref.read(flowStateStreamController).sink.add(ErrorState(StateType.fullScreenError, 'Error')),
      (scoresModel) {
        _ref.read(flowStateStreamController).sink.add(NormalState());
        _ref.read(scoresModelStreamController).sink.add(scoresModel);
      },
    );
  }
}
