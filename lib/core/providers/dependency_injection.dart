import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/repository/repository_implementer.dart';
import '../../domain/repository/repository.dart';
import '../network/app_service_client.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';

final instance = GetIt.instance;

Future<void> initModules() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerSingleton<SharedPreferences>(
    sharedPrefs,
  );

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(),
  );

  instance.registerLazySingleton<Dio>(
    () => instance<DioFactory>().getDio(),
  );

  instance.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementer(instance<Connectivity>()),
  );

  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(instance<Dio>()),
  );

  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementer(sharedPrefs),
  );

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(instance<AppServiceClient>(), instance<LocalDataSource>()),
  );

  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementer(instance<RemoteDataSource>(), instance<LocalDataSource>(), instance<NetworkInfo>()),
  );
}

final dioFactoryProvider = Provider.autoDispose<DioFactory>((ref) {
  return instance<DioFactory>();
});

final dioProvider = Provider.autoDispose<Dio>((ref) {
  return instance<Dio>();
});

final appServiceClientProvider = Provider.autoDispose<AppServiceClient>((ref) {
  final dio = ref.watch(dioProvider);

  return AppServiceClient(dio);
});

final localDataSourceProvider = Provider.autoDispose<LocalDataSource>((ref) {
  final sharedPrefs = instance<SharedPreferences>();
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
