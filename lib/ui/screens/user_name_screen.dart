import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_text_field.dart';

class UserNameScreen extends HookConsumerWidget {
  const UserNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();

    bool validateUserName(String? userName) => userName != null && userName.isNotEmpty;
    void gotoAuthWrapper() => Navigator.of(context).pushNamedAndRemoveUntil(kAuthWrapperRoute, ((route) => false));

    void updateUserName() async {
      final token = ref.watch(tokenProvider);
      final userName = nameController.text.trim();

      final isUserNameValid = validateUserName(userName);

      if (isUserNameValid) {
        final success = await ref.watch(authProvider).updateUserNameAndAddUser(token: token, userName: userName);

        if (success) {
          ref.refresh(isTokenValidProvider);
          gotoAuthWrapper();
        }
      } else {
        dev.log('user name is not valid');
      }
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),
              Text('QuizU', style: kHeadLineTextStyle),
              const SizedBox(height: 160),
              const Text(
                'What is your name?',
                style: TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 50),
              CustomTextField(
                label: '',
                controller: nameController,
                align: TextAlign.center,
                style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 70),
              CustomButton(
                'Done',
                width: size.width * 0.5,
                onPressed: updateUserName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
