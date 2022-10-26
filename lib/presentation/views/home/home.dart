import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

  @override
  void initState() {
    model = instance<HomeViewModel>();

    model.loggedOut.stream.listen(
      (isLoggedOut) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context).pushReplacementNamed(Routes.loginView),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: model.logout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ),
    );
  }
}
