import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/providers.dart';
import '../widgets/loading_indicator.dart';
import 'home_wrapper.dart';
import 'login_screen.dart';

class AuthWrapper extends HookConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTokenValidFuture = ref.watch(isTokenValidProvider);

    return isTokenValidFuture.when(
      data: (isTokenValid) => isTokenValid ? const HomeWrapper() : const LoginScreen(),
      error: (err, stack) => Scaffold(body: Center(child: Text('$err $stack'))),
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
