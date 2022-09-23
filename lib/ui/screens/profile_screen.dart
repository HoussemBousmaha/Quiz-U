import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';
import 'package:quiz_u/ui/widgets/loading_indicator.dart';

final dio = Dio();

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameNotifier = useState<String?>(null);
    final mobileNotifier = useState<String?>(null);
    useAsyncEffect(() async {
      final data = await ref.read(authProvider).fetchUserInfo();

      // update the local state
      userNameNotifier.value = data?['name'];
      mobileNotifier.value = data?['mobile'];

      return null;
    }, []);

    return Scaffold(
      body: ref.watch(isLoadingProvider)
          ? const CustomLoadingIndicator()
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(userNameNotifier.value ?? "No userName"),
                  Text(mobileNotifier.value ?? "No userName"),
                ],
              ),
            ),
    );
  }
}
