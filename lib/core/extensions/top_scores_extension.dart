import '../../data/model/response/top_scores_response.dart';
import '../../domain/entities/score_model.dart';
import '../../domain/entities/scores_model.dart';
import 'score_extension.dart';

final emptyList = const Iterable.empty().cast<ScoreModel>().toList();

extension TopScoresExtension on ScoresResponse? {
  ScoresModel toDomain() => ScoresModel(
        scores: this?.scores?.map((score) => score.toDomain()).toList() ?? emptyList,
      );
}
