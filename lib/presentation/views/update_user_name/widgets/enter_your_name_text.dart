import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';

class EnterYourNameText extends StatelessWidget {
  const EnterYourNameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.whatIsYourName,
      style: Theme.of(context).textTheme.headline1?.copyWith(color: ColorManager.primaryButtonColor),
    );
  }
}
