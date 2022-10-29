import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';

class UserNameField extends HookConsumerWidget {
  const UserNameField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      height: AppSize.hs60,
      child: TextField(
        onChanged: (name) => ref.read(userNameProvider.notifier).state = name,
        cursorColor: ColorManager.white,
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: null,
        expands: true,
        keyboardType: TextInputType.name,
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSize.ws20),
          hintText: AppStrings.enterName,
          hintStyle: Theme.of(context).textTheme.headline4,
          filled: true,
          fillColor: ColorManager.textFieldFillColor,
        ),
      ),
    );
  }
}
