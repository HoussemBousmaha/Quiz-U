import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/controllers/auth.dart';
import 'package:quiz_u/controllers/database.dart';
import 'package:quiz_u/controllers/utils.dart';

final authStateProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final authProvider = StateProvider.autoDispose<Auth>(
  (ref) => Auth(ref),
);

final tokenProvider = StateProvider<String>(
  (ref) => "",
);

final isLoadingProvider = StateProvider<bool>(
  (ref) => true,
);

final databaseProvider = Provider.autoDispose<DatabaseHelper>(
  (ref) => DatabaseHelper(),
);

final mobileNumberProvider = StateProvider<String>(
  (ref) => '',
);

final isTokenValidProvider = FutureProvider.autoDispose<bool>((ref) async {
  final isTokenValid = await ref.read(authProvider).verifyTokenOnAppLunch();
  await Future.delayed(const Duration(milliseconds: 800));
  return isTokenValid;
});

final loadUserInfoProvider = FutureProvider<Map?>((ref) async {
  final data = await ref.read(authProvider).fetchUserInfo();
  return data;
});
final logUserInProvider = FutureProvider.autoDispose<AuthState?>((ref) async {
  final mobileNumber = ref.watch(mobileNumberProvider);

  final signUpOrLogin = await ref.read(authProvider).loginOrSignUp(mobileNumber: mobileNumber);
  return signUpOrLogin;
});
