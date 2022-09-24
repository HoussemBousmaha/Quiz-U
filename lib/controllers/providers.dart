import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/auth.dart';
import 'package:quiz_u/controllers/database.dart';

final authProvider = StateProvider.autoDispose<Auth>(
  (ref) => Auth(ref),
);

final tokenProvider = StateProvider<String>(
  (ref) => '',
);

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

final loadUserInfoProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final data = await ref.read(authProvider).fetchUserInfo();

  return data;
});

final fetchQuestionsProvider = FutureProvider.autoDispose<List>((ref) async {
  final token = ref.watch(tokenProvider);
  final responce = await ref.read(dioClientProvider).get(kQuestionUrl, options: Options(headers: {HttpHeaders.authorizationHeader: token}));
  final data = responce.data;
  return data;
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
