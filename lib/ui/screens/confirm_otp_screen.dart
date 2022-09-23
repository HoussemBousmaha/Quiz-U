import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/ui/widgets/code_sent_card.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';

class ConfirmOTPScreen extends HookConsumerWidget {
  const ConfirmOTPScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    void goToHomeScreen() => Navigator.of(context).pushNamedAndRemoveUntil(kHomeScreenRoute, ((route) => false));

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
              OtpTextField(
                autoFocus: true,
                numberOfFields: 4,
                cursorColor: kPrimaryButtonColor,
                borderColor: Colors.white,
                enabledBorderColor: kPrimaryTextFieldBorderColor,
                focusedBorderColor: kTextFeildFillColor,
                fieldWidth: 60,
                styles: const [
                  TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
                  TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
                  TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
                  TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
                ],

                filled: true,
                fillColor: kTextFeildFillColor,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  dev.log(verificationCode);
                  if (verificationCode == "0000") {
                    goToHomeScreen();
                  } else {
                    // TODO: Alert Dialog
                    dev.log('wrong otp');
                  }
                }, // end onSubmit
              ),
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
