import 'package:rxdart/subjects.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../base/base_view_model.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class ConfirmOtpViewModel extends BaseViewModel {
  final BehaviorSubject<bool> isLoggedInSuccess = BehaviorSubject<bool>();
  final BehaviorSubject<bool> isNewUser = BehaviorSubject<bool>();

  final LoginUseCase _loginUseCase;
  ConfirmOtpViewModel(this._loginUseCase);

  @override
  void start() {}

  Future<void> login(String mobile) async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _loginUseCase.execute(LoginUseCaseInput(mobile: mobile))).fold(
      (failure) => inputState.add(
        ErrorState(stateRendererType: StateRendererType.fullScreenErrorState, message: failure.message),
      ),
      (loginModel) {
        inputState.add(ContentState());

        final userStatus = loginModel.userStatus;

        if (userStatus.isNotEmpty && userStatus == 'new') {
          isNewUser.add(true);
        } else {
          isLoggedInSuccess.add(true);
        }
      },
    );
  }
}
