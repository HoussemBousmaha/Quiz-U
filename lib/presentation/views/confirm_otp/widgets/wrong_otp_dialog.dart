import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';

class WrongOtpDialog extends StatelessWidget {
  const WrongOtpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(alignment: Alignment.center, child: const Text(AppStrings.error)),
      titleTextStyle: Theme.of(context).textTheme.headline1?.copyWith(
            color: ColorManager.primaryButtonColor,
          ),
      content: Container(
        alignment: Alignment.center,
        height: AppSize.hs50,
        child: Text(
          AppStrings.otpError,
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(color: ColorManager.primaryButtonColor, fontSize: FontSize.s16),
        ),
      ),
      actions: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: AppSize.ws20, vertical: AppSize.hs10),
            ),
            onPressed: Navigator.of(context).pop,
            child: Text(AppStrings.ok, style: Theme.of(context).textTheme.headline2),
          ),
        ),
      ],
    );
  }
}
