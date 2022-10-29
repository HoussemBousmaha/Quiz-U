import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../update_user_name_vm.dart';

class UpdateUserNameButton extends StatefulHookConsumerWidget {
  const UpdateUserNameButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateUserNameButtonState();
}

class _UpdateUserNameButtonState extends ConsumerState<UpdateUserNameButton> {
  late final UpdateUserNameViewModel model;

  @override
  void initState() {
    model = ref.read(updateUserNameViewModelProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(userNameProvider);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSize.ws80),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primaryButtonColor,
          padding: EdgeInsets.symmetric(vertical: AppSize.hs10),
        ),
        onPressed: () => model.updateUserName(userName),
        child: Text(
          AppStrings.done,
          style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: FontSize.s18),
        ),
      ),
    );
  }
}
