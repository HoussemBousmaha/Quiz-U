import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';

final dio = Dio();

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataAsyncValue = ref.watch(loadUserInfoProvider);

    return userDataAsyncValue.when(
      data: (userInfo) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(userInfo?['name'] ?? "No userName"),
              Text(userInfo?['mobile'] ?? "No userName"),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) {
        dev.log('$error $stackTrace');
        return Scaffold(body: Center(child: Text('$error $stackTrace')));
      },
      loading: () => const CustomLoadingIndicator(),
    );
  }
}
