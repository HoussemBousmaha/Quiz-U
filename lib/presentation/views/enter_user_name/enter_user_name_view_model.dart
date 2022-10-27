import 'package:quiz_u_final/domain/usecases/logout_usecase.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/usecases/update_user_name_usecase.dart';
import '../base/base_view_model.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class EnterUserNameViewModel extends BaseViewModel {
  @override
  void start() {}

  final UpdateUserNameUseCase _updateUserNameUseCase;
  final LogoutUseCase _logoutUseCase;

  final BehaviorSubject<bool> isLoggedInSuccess = BehaviorSubject<bool>();
  final BehaviorSubject<bool> loggedOut = BehaviorSubject<bool>();
  EnterUserNameViewModel(this._updateUserNameUseCase, this._logoutUseCase);

  Future<void> logout() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _logoutUseCase.execute(null)).fold(
      (failure) => inputState.add(
        ErrorState(stateRendererType: StateRendererType.fullScreenErrorState, message: failure.message),
      ),
      (isLoggedOut) {
        inputState.add(ContentState());
        loggedOut.add(true);
      },
    );
  }

  Future<void> updateUserName(String name) async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _updateUserNameUseCase.execute(
      UpdateUserNameUseCaseInput(name: name),
    ))
        .fold(
      (failure) => inputState.add(
        ErrorState(stateRendererType: StateRendererType.fullScreenErrorState, message: failure.message),
      ),
      (updateUserNameModel) {
        inputState.add(ContentState());
        isLoggedInSuccess.add(true);
      },
    );
  }
}
