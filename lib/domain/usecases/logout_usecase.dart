import 'package:dartz/dartz.dart';

import '../../core/base/base_usecase.dart';
import '../../core/error/failure.dart';
import '../repository/repository.dart';

class LogoutUseCase extends BaseUseCase<void, bool> {
  final Repository _repository;

  LogoutUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await _repository.logout();
  }
}
