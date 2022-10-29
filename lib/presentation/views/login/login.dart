import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/flow_state_provider.dart';
import '../../../core/providers/providers.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../../widgets/logo.dart';
import '../common/flow_state.dart';
import 'login_vm.dart';
import 'widgets/login_button.dart';
import 'widgets/phone_number_field.dart';
import 'widgets/pick_country_field.dart';

class LoginView extends StatefulHookConsumerWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final LoginViewModel model;

  Country? country;

  @override
  void initState() {
    model = ref.read(loginViewModelProvider);
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
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(),
            SizedBox(height: AppSize.hs50),
            const PickCountryField(),
            SizedBox(height: AppSize.hs20),
            const PhoneNumberField(),
            SizedBox(height: AppSize.hs50),
            const LoginButton(),
          ],
        ),
      ),
    );
  }
}
