import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/dependency_injection.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/route_manager.dart';
import '../../../data/data_source/local_data_source.dart';

class SplashView extends StatefulHookConsumerWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  late final LocalDataSource _localDataSource;

  void _startDelay() => Timer(const Duration(milliseconds: 500), _goNext);

  void _goNext() {
    Navigator.of(context).pushReplacementNamed(
      _localDataSource.token.isNotEmpty ? Routes.homeRoute : Routes.loginRoute,
    );
  }

  @override
  void initState() {
    _localDataSource = ref.read(localDataSourceProvider);
    super.initState();

    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.backgroundColor,
    );
  }
}
