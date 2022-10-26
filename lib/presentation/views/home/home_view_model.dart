import 'package:rxdart/subjects.dart';

import '../../../domain/usecases/logout_usecase.dart';
import '../base/base_view_model.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void start() {}

  final LogoutUseCase _logoutUseCase;
  final BehaviorSubject<bool> loggedOut = BehaviorSubject<bool>();
  HomeViewModel(this._logoutUseCase);

  Future<void> logout() async {
    (await _logoutUseCase.execute(null)).fold(
      (failure) => inputState.add(
        ErrorState(stateRendererType: StateRendererType.popupErrorState, message: failure.message),
      ),
      (isLoggedOut) {
        inputState.add(ContentState());
        loggedOut.add(isLoggedOut);
      },
    );
  }
}
