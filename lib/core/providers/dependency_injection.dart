import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u_okoul/core/error/error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/repository/repository_implementer.dart';
import '../../domain/repository/repository.dart';
import '../network/app_service_client.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((_) {
  throw ErrorHandler.handle(DataSource.cacheError);
});

final dioFactoryProvider = Provider<DioFactory>((ref) {
  return DioFactory();
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final appServiceClientProvider = Provider.autoDispose<AppServiceClient>((ref) {
  final dio = ref.watch(dioProvider);

  return AppServiceClient(dio);
});

final localDataSourceProvider = Provider.autoDispose<LocalDataSource>((ref) {
  final sharedPrefs = ref.watch(sharedPrefsProvider);

  return LocalDataSourceImplementer(sharedPrefs);
});

final remoteDataSourceProvider = Provider.autoDispose<RemoteDataSource>((ref) {
  final appServiceClient = ref.watch(appServiceClientProvider);
  final localDataSource = ref.watch(localDataSourceProvider);

  return RemoteDataSourceImplementer(appServiceClient, localDataSource);
});

final connectivityProvider = Provider.autoDispose<Connectivity>((ref) {
  return Connectivity();
});

final networkInfoProvider = Provider.autoDispose<NetworkInfo>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return NetworkInfoImplementer(connectivity);
});

final repositoryProvider = Provider.autoDispose<Repository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  final localDataSource = ref.watch(localDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);

  return RepositoryImplementer(remoteDataSource, localDataSource, networkInfo);
});
