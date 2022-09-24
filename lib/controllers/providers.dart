import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/auth.dart';
import 'package:quiz_u/controllers/database.dart';

final authStateProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final authProvider = StateProvider.autoDispose<Auth>(
  (ref) => Auth(ref),
);

final tokenProvider = StateProvider<String>(
  (ref) => "",
);

final databaseProvider = Provider.autoDispose<DatabaseHelper>(
  (ref) => DatabaseHelper(),
);

final mobileNumberProvider = StateProvider<String>(
  (ref) => '',
);

final isTokenValidProvider = FutureProvider.autoDispose<bool>((ref) async {
  final isTokenValid = await ref.read(authProvider).verifyTokenOnAppLunch();

  return isTokenValid;
});

final loadUserInfoProvider = FutureProvider.autoDispose<Map?>((ref) async {
  final data = await ref.read(authProvider).fetchUserInfo();

  return data;
});

final fetchQuestionsProvider = FutureProvider.autoDispose<List>((ref) async {
  final token = ref.watch(tokenProvider);
  final responce = await ref.read(dioProvider).get(kQuestionUrl, options: Options(headers: {HttpHeaders.authorizationHeader: token}));
  final data = responce.data;
  return data;
});

final screenIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final isQuizStartedProvider = StateProvider(
  (ref) => false,
);

final dioProvider = Provider.autoDispose((ref) => Dio());
