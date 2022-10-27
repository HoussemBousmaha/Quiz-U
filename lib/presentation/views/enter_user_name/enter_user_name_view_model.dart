import 'package:rxdart/subjects.dart';

import '../../../domain/usecases/update_user_name_usecase.dart';
import '../base/base_view_model.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class EnterUserNameViewModel extends BaseViewModel {
  @override
  void start() {}

  final UpdateUserNameUseCase _updateUserNameUseCase;

  final BehaviorSubject<bool> isLoggedInSuccess = BehaviorSubject<bool>();
  EnterUserNameViewModel(this._updateUserNameUseCase);

  Future<void> updateUserName(String name) async {
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
