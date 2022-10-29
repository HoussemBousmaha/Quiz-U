import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/model/requests/login_request.dart';
import '../../data/model/requests/update_user_name_request.dart';
import '../entities/login_model.dart';
import '../entities/scores_model.dart';
import '../entities/update_user_name_model.dart';

abstract class Repository {
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UpdateUserNameModel>> updateUserName(UpdateUserNameRequest updateUserNameRequest);
  Future<Either<Failure, ScoresModel>> getTopScores();
}
