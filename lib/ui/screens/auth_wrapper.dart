import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/screens/home_wrapper.dart';
import 'package:quiz_u/ui/screens/login_screen.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';

class AuthWrapper extends HookConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTokenValidFuture = ref.watch(isTokenValidProvider);

    return isTokenValidFuture.when(
      data: (isTokenValid) {
        log(isTokenValid.toString());
        return isTokenValid ? const HomeWrapper() : const LoginScreen();
      },
      error: (err, stack) => Scaffold(body: Center(child: Text('$err $stack'))),
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
