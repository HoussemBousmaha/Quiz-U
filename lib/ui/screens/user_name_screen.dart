import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../controllers/providers.dart';
import '../../size_config.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class UserNameScreen extends HookConsumerWidget {
  const UserNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final nameController = useTextEditingController();

    bool validateUserName(String? userName) => userName != null && userName.isNotEmpty;
    void gotoAuthWrapper() => Navigator.of(context).pushNamedAndRemoveUntil(kAuthWrapperRoute, ((route) => false));

    void updateUserName() async {
      final userName = nameController.text.trim();

      final isUserNameValid = validateUserName(userName);

      if (isUserNameValid) {
        final success = await ref.watch(authProvider).updateUserName(userName: userName);

        if (success) {
          ref.refresh(isTokenValidProvider);
          gotoAuthWrapper();
        }
      } else {
        print('user name is not valid');
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
              SizeConfig.addVerticalSpace(200),
              Text('QuizU', style: kHeadLineTextStyle),
              SizeConfig.addVerticalSpace(160),
              Text(
                'What is your name?',
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.width(20),
                ),
              ),
              SizeConfig.addVerticalSpace(50),
              CustomTextField(
                label: '',
                controller: nameController,
                align: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.width(16),
                ),
              ),
              SizeConfig.addVerticalSpace(70),
              CustomButton(
                'Done',
                width: SizeConfig.width(190),
                onPressed: updateUserName,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: SizeConfig.width(22)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
