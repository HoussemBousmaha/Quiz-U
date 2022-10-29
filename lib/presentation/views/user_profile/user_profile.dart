import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/providers.dart';
import 'user_profile_vm.dart';

class UserProfileView extends StatefulHookConsumerWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  late final UserProfileViewModel model;

  @override
  void initState() {
    model = ref.read(userProfileViewModelProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: model.logout, child: const Text('Logout')),
      ),
    );
  }
}
