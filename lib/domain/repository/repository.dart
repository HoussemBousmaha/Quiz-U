import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/model/requests/login_request.dart';
import '../entities/login_model.dart';

abstract class Repository {
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, bool>> logout();
}
