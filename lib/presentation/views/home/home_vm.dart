import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../base/base_view_model.dart';
import '../common/flow_state.dart';
import '../common/flow_state_view.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void start() {}

  @override
  void dispose() {}

  final LogoutUseCase _logoutUseCase;
  final ProviderRef _ref;

  HomeViewModel(this._ref) : _logoutUseCase = _ref.read(logoutUseCaseProvider);

  Future<void> logout() async {
    _ref.read(flowStateStreamController).sink.add(LoadingState(StateType.popupLoading, 'Loading...'));
    (await _logoutUseCase.execute(null)).fold(
      (failure) => _ref.read(flowStateStreamController).sink.add(ErrorState(StateType.popupError, 'Error')),
      (isLoggedOut) {
        _ref.read(flowStateStreamController).sink.add(NormalState());
        _ref.read(isUserLoggedOutStreamController).sink.add(true);
      },
    );
  }
}
