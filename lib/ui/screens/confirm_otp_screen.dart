import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/ui/widgets/code_sent_card.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_otp_text_field.dart';

class ConfirmOTPScreen extends HookConsumerWidget {
  const ConfirmOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    void goToAuthWrapper() => Navigator.of(context).pushNamedAndRemoveUntil(kAuthWrapperRoute, (route) => false);
    void goToUserNameScreen() => Navigator.of(context).pushNamedAndRemoveUntil(kUserNameScreenRoute, (route) => false);

    void loginOrSignUp(String otp) async {
      final mobileNumber = ref.watch(mobileNumberProvider);

      final signUpOrLogin = await ref.read(authProvider).loginOrSignUp(mobileNumber: mobileNumber);

      if (signUpOrLogin == AuthState.loggedIn) {
        ref.refresh(isTokenValidProvider);
        goToAuthWrapper();
      } else if (signUpOrLogin == AuthState.signedUp) {
        goToUserNameScreen();
      } else {
        dev.log('There were a problem');
      }
    }

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                height: 110,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          elevation: 0,
                          foregroundColor: kPrimaryButtonColor,
                          padding: const EdgeInsets.all(20),
                        ),
                        child: SvgPicture.asset('assets/arrow_back.svg'),
                      ),
                    ),
                    const CodeSendCard(),
                  ],
                ),
              ),
              const SizedBox(height: 110),
              CustomOtpTextField(onSubmit: loginOrSignUp),
              const SizedBox(height: 110),
              const Text(
                'Didn\'t get the code?',
                style: TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
              CustomButton(
                "Resend",
                width: size.width * .4,
                onPressed: () {
                  // TODO: Implement SMS Sending to send OTP
                },
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
