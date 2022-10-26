import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_u_final/presentation/views/confirm_otp/confirm_otp_view_model.dart';
import 'package:quiz_u_final/presentation/views/login/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/repository/repository_implementer.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../presentation/views/home/home_view_model.dart';
import '../network/app_service_client.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPrefs,
  );

  // local data source
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementer(instance<SharedPreferences>()),
  );

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(instance<AppServiceClient>()),
  );

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementer(Connectivity()),
  );

  // dio factory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance<LocalDataSource>()),
  );

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(dio),
  );

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementer(instance<RemoteDataSource>(), instance<LocalDataSource>(), instance<NetworkInfo>()),
  );

  initLoginModule();
  initLogoutModule();
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    // login use case
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<Repository>()),
    );

    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(),
    );

    // login view model
    instance.registerFactory<ConfirmOtpViewModel>(
      () => ConfirmOtpViewModel(instance<LoginUseCase>()),
    );
  }
}

void initLogoutModule() {
  if (!GetIt.I.isRegistered<LogoutUseCase>()) {
    // login use case
    instance.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(instance<Repository>()),
    );

    // login view model
    instance.registerFactory<HomeViewModel>(
      () => HomeViewModel(instance<LogoutUseCase>()),
    );
  }
}
