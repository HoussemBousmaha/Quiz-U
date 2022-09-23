import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz/controllers/auth.dart';

final authStateProvider = StateProvider<bool>(
  (ref) => false,
);

final authProvider = StateProvider<Auth>(
  (ref) => Auth(ref),
);

final tokenProvider = StateProvider<String>(
  (ref) => "",
);

final isLoadingProvider = StateProvider<bool>(
  (ref) => false,
);
