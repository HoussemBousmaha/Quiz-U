import 'dart:developer' as dev;

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_text_field.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    void goToConfirmOtpScreen() => Navigator.of(context).pushNamed(kConfirmOtpScreenRoute);

    final countryCodeNotifier = useState<CountryCode>(
      const CountryCode(name: 'Saudi Arabia', code: 'SA', dialCode: '+966'),
    );

    final mobileController = useTextEditingController();
    final countryCodeController = useTextEditingController(text: '${countryCodeNotifier.value.name} (${countryCodeNotifier.value.dialCode})');

    Future<bool> validateMobileNumber(String mobileNumber) async {
      final phoneNumberUtil = PhoneNumberUtil();

      bool isMobileNumberValid = await phoneNumberUtil.validate(mobileNumber);

      return isMobileNumberValid;
    }

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Text('QuizU', style: kHeadLineTextStyle),
            const SizedBox(height: 130),
            CustomTextField(
              focus: AlwaysDisabledFocusNode(),
              style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold),
              label: "Country/Region",
              controller: countryCodeController,
              prefixIcon: Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                child: countryCodeNotifier.value.flagImage,
              ),
              suffixIcon: const Icon(Icons.arrow_drop_down, size: 35),
              onTap: () async {
                final code = await countryPicker.showPicker(context: context);
                if (code == null) return;
                countryCodeNotifier.value = code;
                countryCodeController.text = '${code.name} (${code.dialCode})';
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold),
              label: "Enter Phone Number",
              controller: mobileController,
              keyBoardType: TextInputType.number,
            ),
            const SizedBox(height: 60),
            CustomButton(
              "Start",
              width: size.width * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              style: kPrimaryTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
              borderRadius: 5,
              onPressed: () async {
                final mobileNumber = '${countryCodeNotifier.value.dialCode}${mobileController.text.trim()}';
                ref.read(mobileNumberProvider.notifier).state = mobileNumber;

                final isMobileNumberValid = await validateMobileNumber(mobileNumber);
                if (isMobileNumberValid) {
                  goToConfirmOtpScreen();
                } else {
                  dev.log('MobileNumberNotValid');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
