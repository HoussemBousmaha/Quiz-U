import 'package:dartz/dartz.dart';

import '../../core/base/base_usecase.dart';
import '../../core/error/failure.dart';
import '../../data/model/requests/update_user_name_request.dart';
import '../entities/update_user_name_model.dart';
import '../repository/repository.dart';

class UpdateUserNameUseCase extends BaseUseCase<UpdateUserNameUseCaseInput, UpdateUserNameModel> {
  final Repository _repository;

  UpdateUserNameUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateUserNameModel>> execute(UpdateUserNameUseCaseInput input) async {
    return await _repository.updateUserName(UpdateUserNameRequest(name: input.name));
  }
}

class UpdateUserNameUseCaseInput {
  final String name;
  UpdateUserNameUseCaseInput({required this.name});
}
