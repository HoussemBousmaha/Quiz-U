import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/auth.dart';
import 'package:quiz_u/controllers/database.dart';
import 'package:quiz_u/models/score.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateProvider.autoDispose<Auth>(
  (ref) => Auth(ref),
);

final tokenProvider = StateProvider<String>(
  (ref) => '',
);

final userScoresProvider = FutureProvider.autoDispose<List<Score>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final previousScores = prefs.getStringList('scores');
  final previousScoresTimes = prefs.getStringList('scoresTime');

  if (previousScores == null || previousScoresTimes == null) return [];

  List<Score> scores = List.generate(
    previousScores.length,
    (index) => Score(
      score: int.parse(previousScores[index]),
      timeSaved: previousScoresTimes[index],
    ),
  );

  scores.sort((a, b) => a.score.compareTo(b.score));
  await Future.delayed(const Duration(seconds: 1));

  return scores;
});

final databaseProvider = Provider.autoDispose<DatabaseHelper>(
  (ref) => DatabaseHelper(),
);

final mobileNumberProvider = StateProvider<String>(
  (ref) => '',
);

final isTokenValidProvider = FutureProvider<bool>((ref) async {
  final isTokenValid = await ref.read(authProvider).verifyTokenOnAppLunch();

  return isTokenValid;
});

final loadUserInfoProvider = FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
  final userInfo = await ref.read(authProvider).fetchUserInfo();

  return userInfo;
});

final topScoresProvider = FutureProvider.autoDispose<List<dynamic>?>((ref) async {
  final topScores = await ref.read(authProvider).fetchTopScores();

  return topScores;
});

final fetchQuestionsProvider = FutureProvider.autoDispose<List?>((ref) async {
  final questions = await ref.read(authProvider).fetchQuestions();
  return questions;
});

final screenIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final isQuizStartedProvider = StateProvider(
  (ref) => false,
);

final dioClientProvider = Provider((ref) => Dio());

final isCorrectAnswersListProvider = StateProvider.autoDispose((ref) {
  return [false, false, false, false];
});

final isAnswerSubmittedProvider = StateProvider.autoDispose((ref) {
  return [false, false, false, false];
});

final questionIndexProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final angleProvider = StateProvider.autoDispose<double>(
  (ref) => 0.0,
);
final timeProvider = StateProvider.autoDispose<double>(
  (ref) => kDefaultQuizTime.toDouble(),
);
