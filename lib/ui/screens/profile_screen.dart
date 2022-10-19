import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../controllers/providers.dart';
import '../../size_config.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/user_scores_list_view.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final userDataAsyncValue = ref.watch(loadUserInfoProvider);
    void gotoAuthWrapper() => Navigator.of(context).pushReplacementNamed(kAuthWrapperRoute);

    Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('scores');
      prefs.remove('scoresTime');
      ref.refresh(isTokenValidProvider);
      gotoAuthWrapper();
    }

    return userDataAsyncValue.when(
      data: (userInfo) {
        return Scaffold(
          backgroundColor: kAppBackgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizeConfig.addVerticalSpace(100),
                Align(
                  alignment: const Alignment(-.85, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kTextFeildFillColor,
                      padding: EdgeInsets.all(SizeConfig.width(15)),
                      shape: const CircleBorder(),
                    ),
                    onPressed: logout,
                    child: const Icon(Icons.logout, color: kPrimaryTextColor),
                  ),
                ),
                SizeConfig.addVerticalSpace(30),
                Text('QuizU', style: kHeadLineTextStyle),
                SizeConfig.addVerticalSpace(40),
                Text(
                  'Profile',
                  style: kHeadLineTextStyle.copyWith(
                    fontSize: SizeConfig.width(25),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizeConfig.addVerticalSpace(40),
                Container(
                  height: SizeConfig.height(60),
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.width(60)),
                  decoration: BoxDecoration(
                    color: kTextFeildFillColor,
                    border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                  ),
                  child: Text(
                    userInfo?['name'] ?? "No userName",
                    style: TextStyle(
                      color: kPrimaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.width(15),
                    ),
                  ),
                ),
                SizeConfig.addVerticalSpace(10),
                Container(
                  height: SizeConfig.height(60),
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.width(60)),
                  decoration: BoxDecoration(
                    color: kTextFeildFillColor,
                    border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                  ),
                  child: Text(
                    userInfo?['mobile'] ?? "No userName",
                    style: TextStyle(
                      color: kPrimaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.width(15),
                    ),
                  ),
                ),
                SizeConfig.addVerticalSpace(30),
                Text(
                  'My Scores',
                  style: kHeadLineTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.width(25),
                  ),
                ),
                SizeConfig.addVerticalSpace(40),
                const UserScoresListView(),
                SizeConfig.addVerticalSpace(20),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(body: Center(child: Text('$error $stackTrace')));
      },
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
