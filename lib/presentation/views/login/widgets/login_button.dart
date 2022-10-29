import 'package:flutter/material.dart';

import '../../../../core/resources/route_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.hs50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSize.ws40),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.confirmOtpRoute),
        child: Text(
          AppStrings.start,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
