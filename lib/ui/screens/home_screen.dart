import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void gotoLoginScreen() => Navigator.of(context).pushReplacementNamed(kLoginScreenRoute);

    void gotoProfileScreen() => Navigator.of(context).pushNamed(kProfileScreenRoute);

    Future<void> logout() async {
      // remove the token
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      gotoLoginScreen();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Logged In'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                gotoProfileScreen();
              },
              style: TextButton.styleFrom(backgroundColor: const Color(0xFF5B61FE)),
              child: const Text('Goto profile screen', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: logout,
              style: TextButton.styleFrom(backgroundColor: const Color(0xFF5B61FE)),
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
