import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/custom_text_field.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goToUserNameScreen() => Navigator.of(context).pushReplacementNamed(kUserNameScreenRoute);

    void goToHomeScreen() => Navigator.of(context).pushReplacementNamed(kHomeScreenRoute);

    final countryCodeNotifier = useState<CountryCode>(
      const CountryCode(name: 'Saudi Arabia', code: 'SA', dialCode: '+966'),
    );

    final mobileController = useTextEditingController();
    final countryCodeController = useTextEditingController(text: '${countryCodeNotifier.value.name} (${countryCodeNotifier.value.dialCode})');

    return ref.watch(isLoadingProvider)
        ? const CustomLoadingIndicator()
        : Scaffold(
            backgroundColor: kAppBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  Text('QuizU', style: kHeadLineTextStyle),
                  const SizedBox(height: 130),
                  CustomTextField(
                    controller: countryCodeController,
                    focus: AlwaysDisabledFocusNode(),
                    style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold),
                    label: "Country/Region",
                    prefixIcon: Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                      child: countryCodeNotifier.value.flagImage,
                    ),
                    suffixIcon: const Icon(Icons.arrow_drop_down, size: 35),
                    keyBoardType: TextInputType.number,
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
                  const SizedBox(height: 150),
                  CustomButton(
                    "Start",
                    width: 200,
                    height: 65,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    style: kPrimaryTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    borderRadius: 5,
                    onPressed: () async {
                      final mobileNumber = '${countryCodeNotifier.value.dialCode}${mobileController.text.trim()}';

                      final signUpOrLogin = await ref.read(authProvider).loginOrSignUp(mobileNumber: mobileNumber);

                      if (signUpOrLogin == null) return;

                      signUpOrLogin == AuthState.signedUp ? goToUserNameScreen() : goToHomeScreen();
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
