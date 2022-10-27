import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/app/app.router.dart';
import '../../../core/dependecy_injection/dependency_injection.dart';
import '../../../core/providers/providers.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../../widgets/logo.dart';
import '../common/state_renderer/state_renderer_implementer.dart';
import 'login_view_model.dart';

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
    model = instance<LoginViewModel>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: model.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget()) ?? _getContentWidget();
        },
      ),
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
            _getPickCountryField(),
            SizedBox(height: AppSize.hs20),
            _getEnterPhoneNumberField(),
            SizedBox(height: AppSize.hs50),
            _getLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _getLoginButton() {
    return Container(
      height: AppSize.hs50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSize.ws40),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.confirmOtpView),
        child: Text(
          AppStrings.start,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }

  Widget _getEnterPhoneNumberField() {
    return Container(
      alignment: Alignment.center,
      height: AppSize.hs60,
      child: TextField(
        onSubmitted: (_) => Navigator.of(context).pushNamed(Routes.confirmOtpView),
        onChanged: (mobileNumber) => ref.read(mobileNumberProvider.notifier).state = mobileNumber,
        cursorColor: ColorManager.white,
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: null,
        expands: true,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
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

  Widget _getPickCountryField() {
    return GestureDetector(
      onTap: () => showCountryPicker(
        context: context,
        onSelect: (pickedCountry) => setState(() => country = pickedCountry),
      ),
      child: Container(
        height: AppSize.hs60,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorManager.textFieldFillColor,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.ws5)),
          border: Border.all(color: ColorManager.white),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.countryOrRegion,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: AppSize.hs8),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.hs2)),
                        child: Image.asset(
                          'icons/flags/png/${country?.countryCode.toLowerCase() ?? 'sa'}.png',
                          package: 'country_icons',
                          fit: BoxFit.cover,
                          height: AppSize.hs16,
                        ),
                      ),
                      SizedBox(width: AppSize.ws10),
                      Text(country?.name ?? AppStrings.saudiArabia, style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down, size: AppSize.hs30)
          ],
        ),
      ),
    );
  }
}
