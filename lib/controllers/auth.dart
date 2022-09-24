import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  const Auth(this.ref);
  final StateProviderRef ref;

  Future<void> dos() async {}

  Future<bool?> login({required String mobileNumber, String otp = otp}) async {
    try {
      // http
      final body = '{ "OTP":"$otp", "mobile":"$mobileNumber" }';
      final responce = await ref.read(dioProvider).post(kLoginUrl, data: body);
      final data = responce.data;

      // set token to local storage and to the provider
      final prefs = await SharedPreferences.getInstance();
      final token = data['token'];
      prefs.setString('token', token);
      ref.watch(tokenProvider.notifier).state = token;

      if (data['user_status'] != null) {
        return true;
      } else {
        // add to firestore
        final user = User(name: data['name'], mobile: data['mobile'], token: token);
        ref.read(databaseProvider).addUser(user);

        return false;
      }
    } catch (err) {
      print('this is the error : $err');
      return null;
    }
  }

  Future<bool> updateUserNameAndAddUser({required String token, required String userName}) async {
    try {
      final body = '{ "OTP":"$otp", "name":"$userName" }';

      final responce = await ref.read(dioProvider).post(
            kUserNameUrl,
            data: body,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );

      final data = responce.data;

      // create the user object
      final user = User(
        name: userName,
        mobile: data['mobile'],
        token: token,
      );
      // add to firestore
      ref.read(databaseProvider).addUser(user);

      return responce.data['success'];
    } catch (err) {
      print('$err');
      return false;
    }
  }

  Future<Map?> fetchUserInfo() async {
    try {
      final token = ref.watch(tokenProvider);

      final responce = await ref.read(dioProvider).get(
            kUserInfoUrl,
            options: Options(headers: {HttpHeaders.authorizationHeader: token}),
          );

      return responce.data;
    } catch (err) {
      print('$err');
      return null;
    }
  }

  Future<bool> verifyTokenOnAppLunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        return false;
      }

      final responce = await ref.read(dioProvider).get(kAuthTokenUrl, options: Options(headers: {HttpHeaders.authorizationHeader: token}));
      ref.read(tokenProvider.notifier).state = token;

      return responce.data['success'];
    } catch (err) {
      print('$err');
      return false;
    }
  }
}
