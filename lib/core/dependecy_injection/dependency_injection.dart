import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_u_final/presentation/views/leader_board/leader_board_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/repository/repository_implementer.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecases/get_top_scores_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/update_user_name_usecase.dart';
import '../../presentation/views/confirm_otp/confirm_otp_view_model.dart';
import '../../presentation/views/home/home_view_model.dart';
import '../../presentation/views/login/login_view_model.dart';
import '../../presentation/views/update_user_name/update_user_name_view_model.dart';
import '../network/app_service_client.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPrefs,
  );

  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementer(instance<SharedPreferences>()),
  );

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(instance<AppServiceClient>(), instance<LocalDataSource>()),
  );

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementer(Connectivity()),
  );

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(),
  );

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(dio),
  );

  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementer(instance<RemoteDataSource>(), instance<LocalDataSource>(), instance<NetworkInfo>()),
  );

  initLoginModule();
  initHomeModule();
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<Repository>()),
    );

    instance.registerFactory<ConfirmOtpViewModel>(
      () => ConfirmOtpViewModel(instance<LoginUseCase>()),
    );

    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(),
    );

    instance.registerFactory<UpdateUserNameUseCase>(
      () => UpdateUserNameUseCase(instance<Repository>()),
    );

    instance.registerFactory<UpdateUserNameViewModel>(
      () => UpdateUserNameViewModel(instance<UpdateUserNameUseCase>(), instance<LogoutUseCase>()),
    );
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<LogoutUseCase>()) {
    instance.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(instance<Repository>()),
    );

    instance.registerFactory<TopScoresUseCase>(
      () => TopScoresUseCase(instance<Repository>()),
    );

    instance.registerFactory<HomeViewModel>(
      () => HomeViewModel(instance<LogoutUseCase>()),
    );

    instance.registerFactory<LeaderBoardViewModel>(
      () => LeaderBoardViewModel(instance<TopScoresUseCase>()),
    );
  }
}
