import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/app/app.router.dart';
import '../../../core/dependecy_injection/dependency_injection.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../../../data/data_source/local_data_source.dart';
import '../common/state_renderer/state_renderer_implementer.dart';
import 'enter_user_name_view_model.dart';

class EnterUserNameView extends StatefulHookConsumerWidget {
  const EnterUserNameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterUserNameViewState();
}

class _EnterUserNameViewState extends ConsumerState<EnterUserNameView> {
  late final EnterUserNameViewModel model;
  late final LocalDataSource _localDataSource;
  late final TextEditingController controller;

  @override
  void initState() {
    model = instance<EnterUserNameViewModel>();
    _localDataSource = instance<LocalDataSource>();
    controller = TextEditingController();

    model.isLoggedInSuccess.stream.listen(
      (isSuccessLoggedIn) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.homeView),
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
          return snapshot.data?.getScreenWidget(context, _getContentWidget()) ?? _getContentWidget();
        },
      ),
    );
  }

  Scaffold _getContentWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryButtonColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.confirmOtpView),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppStrings.whatIsYourName, style: Theme.of(context).textTheme.headline1),
            SizedBox(height: AppSize.hs100),
            Container(
              alignment: Alignment.center,
              height: AppSize.hs60,
              child: TextField(
                controller: controller,
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
                  filled: true,
                  fillColor: ColorManager.textFieldFillColor,
                ),
              ),
            ),
            SizedBox(height: AppSize.hs100),
            Container(
              height: AppSize.hs50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: AppSize.ws40),
              child: ElevatedButton(
                onPressed: () async {
                  model.updateUserName(controller.text);
                },
                child: Text(
                  AppStrings.done,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
