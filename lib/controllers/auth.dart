import 'dart:developer' as dev;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/controllers/providers.dart';
import 'package:quiz/controllers/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class Auth {
  const Auth(this.ref);
  final StateProviderRef ref;

  Future<AuthState> loginOrSignUp(BuildContext context, {required String mobileNumber, String otp = "0000"}) async {
    bool isMobileNumberValid = await PhoneNumberUtil().validate(mobileNumber);

    if (isMobileNumberValid) {
      try {
        // http
        final body = '{ "OTP":"$otp", "mobile":"$mobileNumber" }';
        final responce = await dio.post(loginUrl, data: body);
        final data = responce.data;

        // set token to local storage and to the provider
        final prefs = await SharedPreferences.getInstance();
        final token = data['token'];
        prefs.setString('token', token);
        ref.read(tokenProvider.notifier).state = token;

        if (data['user_status'] == 'new') {
          return AuthState.signedUp;
        } else {
          return AuthState.loggedIn;
        }
      } catch (err) {
        dev.log('error: $err');
        return AuthState.error;
      }
    } else {
      dev.log('phone number is not valid');
      return AuthState.error;
    }
  }

  Future<bool> verifyTokenOnAppLunch({required String token}) async {
    try {
      final responce = await dio.get(authStateUrl, options: Options(headers: {HttpHeaders.authorizationHeader: token}));

      return responce.data['success'];
    } catch (err) {
      dev.log('$err');

      return false;
    }
  }

  Future<bool> updateUserName({required String token, required String userName}) async {
    try {
      final body = '{ "OTP":"$otp", "name":"$userName" }';
      final responce = await dio.post(
        userNameUrl,
        data: body,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: token,
        }),
      );

      return responce.data['success'];
    } catch (err) {
      dev.log('$err');

      return false;
    }
  }
}
