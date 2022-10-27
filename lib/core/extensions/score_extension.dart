import '../../data/model/response/score_response.dart';
import '../../domain/entities/score_model.dart';

const String empty = '';
const int zero = 0;

extension ScoreResponseExtension on ScoreResponse? {
  ScoreModel toDomain() => ScoreModel(name: this?.name ?? empty, score: this?.score ?? zero);
}
