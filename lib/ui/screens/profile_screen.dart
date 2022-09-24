import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/widgets/custom_button.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';
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
      ref.refresh(isTokenValidProvider);
      gotoAuthWrapper();
    }

    final size = MediaQuery.of(context).size;

    return userDataAsyncValue.when(
      data: (userInfo) => Scaffold(
        backgroundColor: kAppBackgroundColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(userInfo?['name'] ?? "No userName"),
              Text(userInfo?['mobile'] ?? "No userName"),
              const SizedBox(height: 50),
              CustomButton(
                'Logout',
                width: size.width * 0.5,
                onPressed: logout,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) {
        print('$error $stackTrace');
        return Scaffold(body: Center(child: Text('$error $stackTrace')));
      },
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
