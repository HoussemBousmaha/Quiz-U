import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/controllers/providers.dart';
import 'package:quiz/controllers/utils.dart';
import 'package:quiz/ui/widgets/loading_indicator.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goToUserNameScreen() => Navigator.of(context).pushReplacementNamed(userNameScreenRoute);
    void gotoHomeScreen() => Navigator.of(context).pushReplacementNamed(homeScreenRoute);

    final mobileController = useTextEditingController();
    return Consumer(
      builder: ((context, ref, child) {
        return Scaffold(
          body: ref.watch(isLoadingProvider)
              ? const CustomLoadingIndicator()
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: TextField(controller: mobileController, decoration: const InputDecoration(border: OutlineInputBorder())),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF5B61FE),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () async {
                          ref.read(isLoadingProvider.notifier).state = true;

                          final mobileNumber = mobileController.text.trim();
                          final signUpOrLogin = await ref.read(authProvider).loginOrSignUp(context, mobileNumber: mobileNumber);

                          if (signUpOrLogin == AuthState.signedUp) {
                            goToUserNameScreen();
                          } else if (signUpOrLogin == AuthState.loggedIn) {
                            gotoHomeScreen();
                          } else if (signUpOrLogin == AuthState.error) {
                            dev.log('error');
                          }

                          ref.read(isLoadingProvider.notifier).state = false;
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
