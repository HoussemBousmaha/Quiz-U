import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../core/extensions/general_extensions.dart';
import '../../core/extensions/login_response_extension.dart';
import '../../core/extensions/top_scores_extension.dart';
import '../../core/extensions/update_user_name_response_extension.dart';
import '../../domain/entities/login_model.dart';
import '../../domain/entities/scores_model.dart';
import '../../domain/entities/update_user_name_model.dart';
import '../../domain/repository/repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../model/requests/login_request.dart';
import '../model/requests/update_user_name_request.dart';

class RepositoryImplementer extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // it is safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.success == ApiInternalStatus.success) {
          // return data (success)

          final isTokenStored = await _localDataSource.setToken(response.toDomain().token);

          if (isTokenStored) return Right(response.toDomain());

          return Left(ErrorHandler.handle(DataSource.cacheError).failure);
        } else {
          // response.status = ApiInternalStatus.failure
          // return business logic error

          return Left(
            Failure(
              code: 1,
              message: response.message ?? ResponseMessage.defaultError,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    return Right(await _localDataSource.removeToken());
  }

  @override
  Future<Either<Failure, UpdateUserNameModel>> updateUserName(UpdateUserNameRequest updateUserNameRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // it is safe to call the API
        final response = await _remoteDataSource.updateUserName(updateUserNameRequest);

        if (response.success == ApiInternalStatus.success) {
          // return data (success)

          return Right(response.toDomain());
        } else {
          // response.status = ApiInternalStatus.failure
          // return business logic error

          return Left(
            Failure(
              code: 1,
              message: response.message ?? ResponseMessage.defaultError,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ScoresModel>> getTopScores() async {
    try {
      final scoresResponse = _localDataSource.getStoresModel;

      return Right(scoresResponse.toDomain());
    } catch (err) {
      if (await _networkInfo.isConnected) {
        try {
          // it is safe to call the API
          final response = await _remoteDataSource.getTopScores();

          final isStored = await _localDataSource.setScoresResponse(response);

          if (isStored) return Right(response.toDomain());

          return Left(ErrorHandler.handle(DataSource.cacheError).failure);
        } catch (error) {
          error.log();
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return connection error
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
