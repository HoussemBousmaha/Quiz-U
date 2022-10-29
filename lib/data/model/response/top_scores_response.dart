import 'package:json_annotation/json_annotation.dart';

import 'score_response.dart';

part 'top_scores_response.g.dart';

@JsonSerializable()
class ScoresResponse {
  @JsonKey(name: 'scores')
  final List<ScoreResponse>? scores;

  ScoresResponse({this.scores});

  // from json
  factory ScoresResponse.fromJson(Map<String, dynamic> json) => _$ScoresResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ScoresResponseToJson(this);
}
