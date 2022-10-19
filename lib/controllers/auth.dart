import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/score.dart';
import 'providers.dart';

class Auth {
  const Auth(this.ref);
  final StateProviderRef ref;

  Future<void> dos() async {}

  Future<bool?> login({required String mobileNumber, String otp = otp}) async {
    try {
      // http
      final body = '{ "OTP":"$otp", "mobile":"$mobileNumber" }';
      final responce = await ref.read(dioClientProvider).post(kLoginUrl, data: body);
      final data = responce.data;

      // set token to local storage and to the provider
      final prefs = await SharedPreferences.getInstance();
      final token = data['token'];
      prefs.setString('token', token);
      ref.watch(tokenProvider.notifier).state = token;

      if (data['user_status'] != null) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('this is the error : $err');
      return null;
    }
  }

  Future<bool> updateUserName({required String userName}) async {
    try {
      final token = ref.watch(tokenProvider);
      final body = '{ "OTP":"$otp", "name":"$userName" }';

      if (token.isEmpty) return false;

      final responce = await ref.read(dioClientProvider).post(
            kUserNameUrl,
            data: body,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );

      return responce.data['success'];
    } catch (err) {
      print('$err');
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchUserInfo() async {
    try {
      final token = ref.watch(tokenProvider);
      if (token.isEmpty) return null;

      final responce = await ref.read(dioClientProvider).get(
            kUserInfoUrl,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );

      final data = responce.data;

      return data;
    } catch (err) {
      print('$err');
      return null;
    }
  }

  Future<List<dynamic>?> fetchTopScores() async {
    try {
      final token = ref.watch(tokenProvider);
      if (token.isEmpty) return null;

      final responce = await ref.read(dioClientProvider).get(
            kTopScoresUrl,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );
      final scores = responce.data;

      return scores;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List?> fetchQuestions() async {
    try {
      final token = ref.watch(tokenProvider);
      if (token.isEmpty) return null;

      final responce = await ref.read(dioClientProvider).get(
            kQuestionUrl,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );
      final questions = responce.data;

      return questions;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<bool> verifyTokenOnAppLunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return false;

      final responce = await ref
          .read(dioClientProvider)
          .get(kAuthTokenUrl, options: Options(headers: {HttpHeaders.authorizationHeader: token}));
      ref.read(tokenProvider.notifier).state = token;

      return responce.data['success'];
    } catch (err) {
      print('$err');
      return false;
    }
  }

  Future<List<Score>?> saveUserScore(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = ref.watch(tokenProvider);

      if (token.isEmpty) return null;

      final now = DateFormat('hh:mm aaa dd/MM/yyyy').format(DateTime.now());

      // set score to local storage
      final previousScores = prefs.getStringList('scores');
      final previousScoresTimes = prefs.getStringList('scoresTime');

      if (previousScores == null) {
        prefs.setStringList('scores', ['$score']);
      } else {
        prefs.setStringList('scores', [...previousScores, '$score']);
      }

      if (previousScoresTimes == null) {
        prefs.setStringList('scoresTime', [now]);
      } else {
        prefs.setStringList('scoresTime', [...previousScoresTimes, now]);
      }

      List<Score> scores = [];

      if (previousScores == null && previousScoresTimes == null) {
        scores = [Score(score: score, timeSaved: now)];
      } else {
        scores = List.generate(
          previousScores!.length,
          (index) => Score(
            score: int.parse(previousScores[index]),
            timeSaved: previousScoresTimes![index],
          ),
        );
      }

      final body = '{ "score": $score }';

      await ref.read(dioClientProvider).post(
            kSaveUserScoreUrl,
            data: body,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );

      return scores;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
