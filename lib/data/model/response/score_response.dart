import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_response.g.dart';

@JsonSerializable()
class ScoreResponse {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'score')
  final int? score;
  ScoreResponse(this.name, this.score);

  // from json
  factory ScoreResponse.fromJson(Map<String, dynamic> json) => _$ScoreResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ScoreResponseToJson(this);
}
