import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u_final/core/resources/font_manager.dart';

import '../../../core/app/app.router.dart';
import '../../../core/dependecy_injection/dependency_injection.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../common/state_renderer/state_renderer_implementer.dart';
import 'update_user_name_view_model.dart';

class UpdateUserNameView extends StatefulHookConsumerWidget {
  const UpdateUserNameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterUserNameViewState();
}

class _EnterUserNameViewState extends ConsumerState<UpdateUserNameView> {
  late final UpdateUserNameViewModel model;

  late final TextEditingController controller;

  @override
  void initState() {
    model = instance<UpdateUserNameViewModel>();
    controller = TextEditingController();

    model.isLoggedInSuccess.stream.listen(
      (isSuccessLoggedIn) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.homeView),
      ),
    );

    model.loggedOut.stream.listen(
      (_) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.loginView),
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
        leading: IconButton(onPressed: model.logout, icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.whatIsYourName,
              style: Theme.of(context).textTheme.headline1?.copyWith(color: ColorManager.primaryButtonColor),
            ),
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
                  hintStyle: Theme.of(context).textTheme.headline4,
                  filled: true,
                  fillColor: ColorManager.textFieldFillColor,
                ),
              ),
            ),
            SizedBox(height: AppSize.hs100),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: AppSize.ws80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primaryButtonColor,
                  padding: EdgeInsets.symmetric(vertical: AppSize.hs10),
                ),
                onPressed: () => model.updateUserName(controller.text),
                child: Text(
                  AppStrings.done,
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: FontSize.s18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}