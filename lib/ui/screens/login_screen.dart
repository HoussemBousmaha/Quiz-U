import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/size_config.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_text_field.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
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

    void showInvalidMobileDialog() async {
      await showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: kAppBackgroundColor,
            title: const Center(
              child: Text(
                'There was an error',
                style: TextStyle(color: kPrimaryTextColor),
              ),
            ),
            content: Container(
              alignment: Alignment.center,
              height: SizeConfig.height(40),
              child: Text(
                'Invalid Mobile Number',
                style: const TextStyle(color: kPrimaryTextColor).copyWith(fontSize: SizeConfig.width(15)),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryButtonColor),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    }

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizeConfig.addVerticalSpace(190),
            Text('QuizU', style: kHeadLineTextStyle),
            SizeConfig.addVerticalSpace(100),
            CustomTextField(
              focus: AlwaysDisabledFocusNode(),
              style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold),
              label: "Country/Region",
              controller: countryCodeController,
              prefixIcon: Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig.width(15),
                  SizeConfig.height(15),
                  SizeConfig.width(10),
                  SizeConfig.height(15),
                ),
                child: countryCodeNotifier.value.flagImage,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down, size: SizeConfig.height(35)),
              onTap: () async {
                final code = await countryPicker.showPicker(context: context);
                if (code == null) return;
                countryCodeNotifier.value = code;
                countryCodeController.text = '${code.name} (${code.dialCode})';
              },
            ),
            SizeConfig.addVerticalSpace(16),
            CustomTextField(
              style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold),
              label: "Enter Phone Number",
              controller: mobileController,
              keyBoardType: TextInputType.number,
            ),
            const SizedBox(height: 60),
            CustomButton(
              "Start",
              width: SizeConfig.size!.width * 0.45,
              height: SizeConfig.height(50),
              style: kPrimaryTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.height(27),
              ),
              borderRadius: 5,
              onPressed: () async {
                final mobileNumber = '${countryCodeNotifier.value.dialCode}${mobileController.text.trim()}';
                ref.read(mobileNumberProvider.notifier).state = mobileNumber;

                final isMobileNumberValid = await validateMobileNumber(mobileNumber);
                if (isMobileNumberValid) {
                  goToConfirmOtpScreen();
                } else {
                  showInvalidMobileDialog();
                  print('MobileNumberNotValid');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
