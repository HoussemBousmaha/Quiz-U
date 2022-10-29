import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/general_extensions.dart';
import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/route_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../common/flow_state.dart';
import 'update_user_name_vm.dart';
import 'widgets/enter_your_name_text.dart';
import 'widgets/update_user_name_button.dart';
import 'widgets/user_name_field.dart';

class UpdateUserNameView extends StatefulHookConsumerWidget {
  const UpdateUserNameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterUserNameViewState();
}

class _EnterUserNameViewState extends ConsumerState<UpdateUserNameView> {
  late final UpdateUserNameViewModel model;

  @override
  void initState() {
    model = ref.read(updateUserNameViewModelProvider);

    ref.read(isUserLoggedInStreamProvider.stream).listen(
      (isUserLoggedIn) {
        if (isUserLoggedIn && mounted) {
          return SchedulerBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacementNamed(Routes.homeRoute),
          );
        }
      },
    );

    ref.read(isUserLoggedOutStreamProvider.stream).listen(
      (isUserLoggedOut) {
        if (isUserLoggedOut && mounted) {
          return SchedulerBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacementNamed(Routes.loginRoute),
          );
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    'Building'.log();
    final flowState = ref.watch(flowStateStreamProvider);

    return Scaffold(
      body: flowState.whenOrNull(data: (flowState) => flowState.getView(context, _getContentWidget())),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EnterYourNameText(),
            SizedBox(height: AppSize.hs100),
            const UserNameField(),
            SizedBox(height: AppSize.hs40),
            const UpdateUserNameButton(),
            SizedBox(height: AppSize.hs100),
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: ColorManager.primaryButtonColor,
      leading: IconButton(onPressed: model.logout, icon: const Icon(Icons.arrow_back_ios)),
    );
  }
}
