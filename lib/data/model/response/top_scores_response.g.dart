// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_scores_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoresResponse _$ScoresResponseFromJson(Map<String, dynamic> json) =>
    ScoresResponse(
      scores: (json['scores'] as List<dynamic>?)
          ?.map((e) => ScoreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScoresResponseToJson(ScoresResponse instance) =>
    <String, dynamic>{
      'scores': instance.scores,
    };
