import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/app/app.router.dart';
import '../../../core/dependecy_injection/dependency_injection.dart';
import '../../../core/providers/providers.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../common/state_renderer/state_renderer_implementer.dart';
import 'confirm_otp_view_model.dart';

class ConfirmOtpView extends StatefulHookConsumerWidget {
  const ConfirmOtpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends ConsumerState<ConfirmOtpView> {
  late final ConfirmOtpViewModel model;

  @override
  void initState() {
    model = instance<ConfirmOtpViewModel>();

    model.isLoggedInSuccess.stream.listen(
      (isSuccessLoggedIn) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.homeView),
      ),
    );

    model.isNewUser.stream.listen(
      (isSuccessLoggedIn) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.enterUserNameView),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: model.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(context)) ?? _getContentWidget(context);
        },
      ),
    );
  }

  Widget _getContentWidget(BuildContext context) {
    final mobileNumber = ref.watch(mobileNumberProvider);

    return Scaffold(
      appBar: AppBar(backgroundColor: ColorManager.primaryButtonColor),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: ColorManager.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getOtpTextField(context, mobileNumber),
          ],
        ),
      ),
    );
  }

  Widget _getOtpTextField(BuildContext context, String mobileNumber) {
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
      builder: (context) => AlertDialog(
        title: Container(alignment: Alignment.center, child: const Text(AppStrings.error)),
        titleTextStyle: Theme.of(context).textTheme.headline1?.copyWith(
              color: ColorManager.primaryButtonColor,
            ),
        content: Container(
          alignment: Alignment.center,
          height: AppSize.hs50,
          child: Text(
            AppStrings.otpError,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: ColorManager.primaryButtonColor,
                  fontSize: FontSize.s16,
                ),
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
      ),
    );
  }
}
