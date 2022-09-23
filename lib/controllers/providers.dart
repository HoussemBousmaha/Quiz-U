import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_u/controllers/auth.dart';
import 'package:quiz_u/controllers/database.dart';

final authStateProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final authProvider = StateProvider.autoDispose<Auth>(
  (ref) => Auth(ref),
);

final tokenProvider = StateProvider<String>(
  (ref) => "",
);

final isLoadingProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final databaseProvider = Provider.autoDispose<DatabaseHelper>(
  (ref) => DatabaseHelper(),
);
