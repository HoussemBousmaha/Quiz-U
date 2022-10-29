import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../confirm_otp_vm.dart';
import 'wrong_otp_dialog.dart';

class OtpField extends StatefulHookConsumerWidget {
  const OtpField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpFieldState();
}

class _OtpFieldState extends ConsumerState<OtpField> {
  late final ConfirmOtpViewModel model;

  @override
  void initState() {
    model = ref.read(confirmOtpViewModelProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mobileNumber = ref.watch(mobileNumberProvider);
    return OtpTextField(
      autoFocus: true,
      numberOfFields: 4,
      showCursor: true,
      showFieldAsBox: true,
      fieldWidth: AppSize.ws55,
      cursorColor: ColorManager.primaryTextColor,
      filled: true,
      fillColor: ColorManager.textFieldFillColor,
      borderColor: ColorManager.white,
      focusedBorderColor: ColorManager.white,
      enabledBorderColor: ColorManager.white,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      styles: [
        Theme.of(context).textTheme.headline2?.copyWith(fontSize: FontSize.s20),
        Theme.of(context).textTheme.headline2?.copyWith(fontSize: FontSize.s20),
        Theme.of(context).textTheme.headline2?.copyWith(fontSize: FontSize.s20),
        Theme.of(context).textTheme.headline2?.copyWith(fontSize: FontSize.s20),
      ],
      onCodeChanged: (String code) {},
      onSubmit: (String verificationCode) async {
        if (verificationCode != AppStrings.otp) {
          await _showOtpErrorDialog(context);
        } else {
          await model.login('+966$mobileNumber');
        }
      },
    );
  }

  Future<Widget?> _showOtpErrorDialog(BuildContext context) {
    return showDialog<Widget>(
      context: context,
      builder: (context) => const WrongOtpDialog(),
    );
  }
}
