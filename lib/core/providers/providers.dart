import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/scores_model.dart';
import '../../domain/usecases/get_top_scores_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/update_user_name_usecase.dart';
import '../../presentation/views/confirm_otp/confirm_otp_vm.dart';
import '../../presentation/views/home/home_vm.dart';
import '../../presentation/views/leader_board/leader_board_vm.dart';
import '../../presentation/views/login/login_vm.dart';
import '../../presentation/views/update_user_name/update_user_name_vm.dart';
import '../../presentation/views/user_profile/user_profile_vm.dart';
import 'dependency_injection.dart';

final mobileNumberProvider = StateProvider<String>((ref) => '');
final userNameProvider = StateProvider<String>((ref) => '');
final navBarIndexProvider = StateProvider<int>((ref) => 0);

// stream controllers

final isNewUserStreamController = Provider((ref) {
  final controller = StreamController<bool>();

  controller.sink.add(false);

  ref.onDispose(() => controller.close());

  return controller;
});

final isUserLoggedInStreamController = Provider((ref) {
  final controller = StreamController<bool>();

  controller.sink.add(false);

  ref.onDispose(() => controller.close());

  return controller;
});

final isUserLoggedOutStreamController = Provider((ref) {
  final controller = StreamController<bool>();

  controller.sink.add(false);

  ref.onDispose(() => controller.close());

  return controller;
});

final scoresModelStreamController = Provider((ref) {
  final controller = StreamController<ScoresModel>();

  ref.onDispose(() => controller.close());

  return controller;
});

// streams

final isNewUserStreamProvider = StreamProvider<bool>((ref) {
  final controller = ref.watch(isNewUserStreamController);

  ref.onDispose(() => controller.close());

  return controller.stream;
});

final isUserLoggedInStreamProvider = StreamProvider<bool>((ref) {
  final controller = ref.watch(isUserLoggedInStreamController);

  ref.onDispose(() => controller.close());

  return controller.stream;
});

final isUserLoggedOutStreamProvider = StreamProvider<bool>((ref) {
  final controller = ref.watch(isUserLoggedOutStreamController);

  ref.onDispose(() => controller.close());

  return controller.stream;
});

final scoresModelStreamProvider = StreamProvider<ScoresModel>((ref) {
  final controller = ref.watch(scoresModelStreamController);

  ref.onDispose(() => controller.close());

  return controller.stream;
});

// use cases

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return LoginUseCase(repository);
});

final updateUserNameUseCaseProvider = Provider.autoDispose<UpdateUserNameUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return UpdateUserNameUseCase(repository);
});

final logoutUseCaseProvider = Provider.autoDispose<LogoutUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return LogoutUseCase(repository);
});

final topScoresUseCaseProvider = Provider.autoDispose<TopScoresUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return TopScoresUseCase(repository);
});

// view models

final loginViewModelProvider = Provider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(ref);
});

final confirmOtpViewModelProvider = Provider.autoDispose<ConfirmOtpViewModel>((ref) {
  return ConfirmOtpViewModel(ref);
});

final updateUserNameViewModelProvider = Provider.autoDispose<UpdateUserNameViewModel>((ref) {
  return UpdateUserNameViewModel(ref);
});

final homeViewModelProvider = Provider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});

final leaderboardViewModelProvider = Provider.autoDispose<LeaderBoardViewModel>((ref) {
  return LeaderBoardViewModel(ref);
});

final userProfileViewModelProvider = Provider.autoDispose<UserProfileViewModel>((ref) {
  return UserProfileViewModel(ref);
});
