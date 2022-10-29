import 'package:dartz/dartz.dart';

import '../../core/base/base_usecase.dart';
import '../../core/error/failure.dart';
import '../../data/model/requests/login_request.dart';
import '../entities/login_model.dart';
import '../repository/repository.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, LoginModel> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(input) async {
    return await _repository.login(LoginRequest(otp: '0000', mobile: input.mobile));
  }

  @override
  bool operator ==(covariant LoginUseCase other) {
    if (identical(this, other)) return true;

    return other._repository == _repository;
  }

  @override
  int get hashCode => _repository.hashCode;

  @override
  String toString() => 'LoginUseCase(_repository: $_repository)';
}

class LoginUseCaseInput {
  final String mobile;
  LoginUseCaseInput({required this.mobile});
}
