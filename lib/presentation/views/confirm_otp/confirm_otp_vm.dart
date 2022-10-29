import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/general_extensions.dart';
import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../base/base_view_model.dart';
import '../common/flow_state.dart';
import '../common/flow_state_view.dart';

class ConfirmOtpViewModel extends BaseViewModel {
  final ProviderRef _ref;
  final LoginUseCase _loginUseCase;
  ConfirmOtpViewModel(this._ref) : _loginUseCase = _ref.read(loginUseCaseProvider);

  @override
  void start() {}

  @override
  void dispose() {}

  Future<void> login(String mobile) async {
    _ref.read(flowStateStreamController).sink.add(LoadingState(StateType.popupLoading, 'Loading...'));

    (await _loginUseCase.execute(LoginUseCaseInput(mobile: mobile))).fold(
      (failure) => _ref.read(flowStateStreamController).sink.add(ErrorState(StateType.popupError, 'Error')),
      (loginModel) {
        _ref.read(flowStateStreamController).sink.add(NormalState());

        final userStatus = loginModel.userStatus;
        final userName = loginModel.name;

        if ((userStatus.isNotEmpty && userStatus == 'new') || userName.isEmpty) {
          'new user'.log();
          _ref.read(isNewUserStreamController).sink.add(true);
        } else {
          'old user'.log();
          _ref.read(isUserLoggedInStreamController).sink.add(true);
        }
      },
    );
  }
}
