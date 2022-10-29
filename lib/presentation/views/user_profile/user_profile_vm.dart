import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/general_extensions.dart';
import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../common/flow_state.dart';
import '../common/flow_state_view.dart';

class UserProfileViewModel {
  final ProviderRef _ref;
  final LogoutUseCase _logoutUseCase;

  UserProfileViewModel(this._ref) : _logoutUseCase = _ref.read(logoutUseCaseProvider);

  void logout() async {
    _ref.read(flowStateStreamController).sink.add(LoadingState(StateType.popupLoading, 'Loading...'));
    (await _logoutUseCase.execute(null)).fold(
      (failure) => _ref.read(flowStateStreamController).sink.add(ErrorState(StateType.popupError, 'Error')),
      (isUserLoggedOut) {
        isUserLoggedOut.log();
        _ref.read(flowStateStreamController).sink.add(NormalState());
        _ref.read(isUserLoggedOutStreamController).sink.add(isUserLoggedOut);
      },
    );
  }
}
