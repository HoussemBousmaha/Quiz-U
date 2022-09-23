import 'dart:developer' as dev;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class Auth {
  const Auth(this.ref);
  final StateProviderRef ref;

  Future<AuthState?> loginOrSignUp({required String mobileNumber, String otp = otp}) async {
    final phoneNumberUtil = PhoneNumberUtil();

    try {
      bool isMobileNumberValid = await phoneNumberUtil.validate(mobileNumber);

      if (isMobileNumberValid) {
        ref.read(isLoadingProvider.notifier).state = true;

        // http
        final body = '{ "OTP":"$otp", "mobile":"$mobileNumber" }';
        final responce = await dio.post(kLoginUrl, data: body);
        final data = responce.data;

        // set token to local storage and to the provider
        final prefs = await SharedPreferences.getInstance();
        final token = data['token'];
        prefs.setString('token', token);
        ref.watch(tokenProvider.notifier).state = token;

        ref.read(isLoadingProvider.notifier).state = false;

        if (data['user_status'] != null) {
          return AuthState.signedUp;
        } else {
          final user = User(name: data['name'], mobile: data['mobile'], token: token);

          // add to firestore
          ref.read(databaseProvider).addUser(user);
          return AuthState.loggedIn;
        }
      } else {
        dev.log('Unvalid Mobile Number');

        return null;
      }
    } catch (err) {
      dev.log('this is the error : $err');
      ref.read(isLoadingProvider.notifier).state = false;
      return null;
    }
  }

  Future<bool> updateUserNameAndAddUser({required String token, required String userName}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;

      final body = '{ "OTP":"$otp", "name":"$userName" }';

      final responce = await dio.post(
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

      ref.read(isLoadingProvider.notifier).state = false;

      return responce.data['success'];
    } catch (err) {
      dev.log('$err');

      ref.read(isLoadingProvider.notifier).state = false;

      return false;
    }
  }

  Future<Map?> fetchUserInfo() async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;

      final token = ref.watch(tokenProvider);

      final responce = await dio.get(
        kUserInfoUrl,
        options: Options(headers: {HttpHeaders.authorizationHeader: token}),
      );

      await Future.delayed(const Duration(milliseconds: 300));

      ref.read(isLoadingProvider.notifier).state = false;

      return responce.data;
    } catch (err) {
      dev.log('$err');

      ref.read(isLoadingProvider.notifier).state = false;

      return null;
    }
  }

  Future<bool> verifyTokenOnAppLunch() async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        ref.read(isLoadingProvider.notifier).state = false;
        return false;
      }

      final responce = await dio.get(kAuthTokenUrl, options: Options(headers: {HttpHeaders.authorizationHeader: token}));
      ref.read(isLoadingProvider.notifier).state = false;
      return responce.data['success'];
    } catch (err) {
      dev.log('$err');
      ref.read(isLoadingProvider.notifier).state = false;
      return false;
    }
  }
}
