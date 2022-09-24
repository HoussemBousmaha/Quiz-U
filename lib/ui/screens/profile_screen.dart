import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';
import 'package:quiz_u/ui/widgets/user_scores_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataAsyncValue = ref.watch(loadUserInfoProvider);
    void gotoAuthWrapper() => Navigator.of(context).pushReplacementNamed(kAuthWrapperRoute);

    Future<void> logout() async {
      // remove the token
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('scores');
      prefs.remove('scoresTime');
      ref.refresh(isTokenValidProvider);
      gotoAuthWrapper();
    }

    useAsyncEffect(() async {
      return null;
    });

    final size = MediaQuery.of(context).size;

    return userDataAsyncValue.when(
      data: (userInfo) {
        return Scaffold(
          backgroundColor: kAppBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 140),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kTextFeildFillColor,
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                      ),
                      onPressed: logout,
                      child: const Icon(
                        Icons.logout,
                        color: kPrimaryTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('QuizU', style: kHeadLineTextStyle),
                  const SizedBox(height: 55),
                  Text('Profile', style: kHeadLineTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 70),
                  Container(
                    height: 55,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kTextFeildFillColor,
                      border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                    ),
                    child: Text(userInfo?['name'] ?? "No userName", style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 55,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kTextFeildFillColor,
                      border: Border.all(color: kPrimaryTextFieldBorderColor, width: 2),
                    ),
                    child: Text(userInfo?['mobile'] ?? "No userName", style: const TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                  const SizedBox(height: 25),
                  Text('My Scores', style: kHeadLineTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 35),
                  const UserScoresListView(),
                  const SizedBox(height: 20),
                ],
              ),
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
