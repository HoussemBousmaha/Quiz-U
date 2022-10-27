import 'package:rxdart/subjects.dart';

import '../../../domain/entities/scores_model.dart';
import '../../../domain/usecases/get_top_scores_usecase.dart';
import '../base/base_view_model.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class LeaderBoardViewModel extends BaseViewModel {
  LeaderBoardViewModel(this._topScoresUseCase);

  final TopScoresUseCase _topScoresUseCase;

  final BehaviorSubject<ScoresModel> scoresStreamController = BehaviorSubject<ScoresModel>();

  @override
  void start() async => await getTopScores();

  Future<void> getTopScores() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _topScoresUseCase.execute(null)).fold(
      (failure) => inputState.add(
        ErrorState(stateRendererType: StateRendererType.popupErrorState, message: failure.message),
      ),
      (topScores) {
        inputState.add(ContentState());
        scoresStreamController.add(topScores);
      },
    );
  }
}
