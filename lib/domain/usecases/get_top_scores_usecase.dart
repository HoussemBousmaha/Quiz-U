import 'package:dartz/dartz.dart';

import '../../core/base/base_usecase.dart';
import '../../core/error/failure.dart';
import '../entities/scores_model.dart';
import '../repository/repository.dart';

class TopScoresUseCase extends BaseUseCase<void, ScoresModel> {
  final Repository _repository;

  TopScoresUseCase(this._repository);
  @override
  Future<Either<Failure, ScoresModel>> execute(void input) async {
    return await _repository.getTopScores();
  }
}
