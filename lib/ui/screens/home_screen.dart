import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> gotoLoginScreen() async {
      await Navigator.of(context).pushNamed(loginScreenRoute);
    }

    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Logged In'),
                TextButton(
                  onPressed: () async {
                    try {
                      ref.read(isLoadingProvider.notifier).state = true;
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove('token');
                      gotoLoginScreen();
                      ref.read(isLoadingProvider.notifier).state = false;
                    } catch (err) {
                      dev.log('$err');
                    }
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.amber),
                  child: const Text('Log Out'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
