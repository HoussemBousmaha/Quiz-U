import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/route_manager.dart';
import '../common/flow_state.dart';
import 'widgets/otp_field.dart';

class ConfirmOtpView extends StatefulHookConsumerWidget {
  const ConfirmOtpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends ConsumerState<ConfirmOtpView> {
  @override
  void initState() {
    ref.read(isUserLoggedInStreamProvider.stream).listen(
      (isUserLoggedIn) {
        if (isUserLoggedIn && mounted) Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      },
    );

    ref.read(isNewUserStreamProvider.stream).listen(
      (isNewUser) {
        if (isNewUser && mounted) Navigator.of(context).pushReplacementNamed(Routes.updateUserNameRoute);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(flowStateStreamProvider);

    return Scaffold(
      body: flowState.whenOrNull(data: (flowState) => flowState.getView(context, _getContentWidget())),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      appBar: _getAppBar(),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: ColorManager.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [OtpField()],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: ColorManager.primaryButtonColor,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.loginRoute),
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
