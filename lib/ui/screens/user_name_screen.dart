import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/controllers/providers.dart';
import 'package:quiz/ui/widgets/loading_indicator.dart';

class UserNameScreen extends HookConsumerWidget {
  const UserNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();

    void gotoHomeScreen() => Navigator.of(context).pushReplacementNamed(homeScreenRoute);

    bool validateUserName(String? userName) => userName != null && userName.isNotEmpty;

    return Scaffold(
      body: ref.watch(isLoadingProvider)
          ? const CustomLoadingIndicator()
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF5B61FE),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () async {
                      final token = ref.watch(tokenProvider);
                      final userName = nameController.text.trim();

                      final isUserNameValid = validateUserName(userName);

                      if (isUserNameValid) {
                        ref.read(isLoadingProvider.notifier).state = true;

                        final success = await ref.watch(authProvider).updateUserName(token: token, userName: userName);
                        if (success) {
                          gotoHomeScreen();
                        } else {
                          dev.log('there was an error, please try again');
                        }

                        ref.read(isLoadingProvider.notifier).state = false;
                      } else {
                        dev.log('user name is not valid');
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
