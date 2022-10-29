import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs, LoginViewModelOutputs {
  final LoginUseCase _loginUseCase;
  final ProviderRef _ref;

  LoginViewModel(this._ref) : _loginUseCase = _ref.read(loginUseCaseProvider);

  @override
  void start() {}

  @override
  void dispose() {}

  @override
  String toString() => 'LoginViewModel(_loginUseCase: $_loginUseCase, _ref: $_ref)';

  @override
  bool operator ==(covariant LoginViewModel other) {
    if (identical(this, other)) return true;

    return other._loginUseCase == _loginUseCase && other._ref == _ref;
  }

  @override
  int get hashCode => _loginUseCase.hashCode ^ _ref.hashCode;
}

abstract class LoginViewModelInputs {}

abstract class LoginViewModelOutputs {}
