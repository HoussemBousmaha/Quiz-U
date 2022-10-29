import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../core/resources/route_manager.dart';
import '../leader_board/leader_board.dart';
import '../user_profile/user_profile.dart';
import 'widgets/bottom_nav_bar.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  static const screens = [Scaffold(), LeaderBoardView(), UserProfileView()];

  @override
  void initState() {
    ref.read(isUserLoggedOutStreamProvider.stream).listen(
      (isLoggedOut) {
        if (isLoggedOut && mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: screens[ref.watch(navBarIndexProvider)],
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
