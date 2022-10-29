import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/route_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';

class PhoneNumberField extends HookConsumerWidget {
  const PhoneNumberField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      height: AppSize.hs60,
      child: TextField(
        onSubmitted: (_) => Navigator.of(context).pushReplacementNamed(Routes.confirmOtpRoute),
        onChanged: (mobileNumber) => ref.read(mobileNumberProvider.notifier).state = mobileNumber,
        cursorColor: ColorManager.white,
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: null,
        expands: true,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSize.ws20),
          hintText: AppStrings.enterPhoneNumber,
          filled: true,
          fillColor: ColorManager.textFieldFillColor,
        ),
      ),
    );
  }
}
