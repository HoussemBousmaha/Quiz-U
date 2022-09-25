import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/size_config.dart';
import 'package:quiz_u/ui/widgets/code_sent_card.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_otp_text_field.dart';

class ConfirmOTPScreen extends HookConsumerWidget {
  const ConfirmOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    void goToAuthWrapper() => Navigator.of(context).pushNamedAndRemoveUntil(kAuthWrapperRoute, (route) => false);
    void goToUserNameScreen() => Navigator.of(context).pushNamedAndRemoveUntil(kUserNameScreenRoute, (route) => false);

    void loginOrSignUp(String otp) async {
      final mobileNumber = ref.watch(mobileNumberProvider);

      final isNewUser = await ref.read(authProvider).login(mobileNumber: mobileNumber);

      if (isNewUser == true) {
        goToUserNameScreen();
      } else if (isNewUser == false) {
        // not new user
        // refresh the token
        ref.refresh(isTokenValidProvider);
        // go to home screen because token must be valid
        goToAuthWrapper();
      } else {
        print('there is an error');
      }
    }

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizeConfig.addVerticalSpace(100),
              SizedBox(
                height: SizeConfig.height(110),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.width(30)),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          elevation: 0,
                          foregroundColor: kPrimaryButtonColor,
                          padding: EdgeInsets.all(SizeConfig.height(20)),
                        ),
                        child: SvgPicture.asset('assets/arrow_back.svg'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const CodeSendCard(),
                  ],
                ),
              ),
              SizeConfig.addVerticalSpace(110),
              CustomOtpTextField(onSubmit: loginOrSignUp),
              SizeConfig.addVerticalSpace(110),
              const Text(
                'Didn\'t get the code?',
                style: TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizeConfig.addVerticalSpace(30),
              CustomButton(
                "Resend",
                width: SizeConfig.size!.width * .4,
                onPressed: () {
                  print('code resent');
                },
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.width(20),
                ),
              ),
              SizeConfig.addVerticalSpace(200),
            ],
          ),
        ),
      ),
    );
  }
}
