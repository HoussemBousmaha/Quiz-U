import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_u_final/core/resources/color_manager.dart';
import 'package:quiz_u_final/presentation/views/leader_board/leader_board.dart';

import '../../../core/app/app.router.dart';
import '../../../core/dependecy_injection/dependency_injection.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel model;

  int _currentIndex = 0;
  static const screens = [Scaffold(), LeaderBoardView(), Scaffold()];

  @override
  void initState() {
    model = instance<HomeViewModel>();

    model.start();

    model.loggedOut.stream.listen(
      (isLoggedOut) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.loginView),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _getContentWidget(),
      bottomNavigationBar: _getBottomNavBar(),
    );
  }

  Widget _getContentWidget() => screens[_currentIndex];

  Widget _getBottomNavBar() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: ColorManager.primaryButtonColor),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), label: 'LeaderBoard'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Person'),
        ],
      ),
    );
  }
}
