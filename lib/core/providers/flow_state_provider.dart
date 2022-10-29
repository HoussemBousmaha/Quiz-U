import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/views/common/flow_state.dart';

final flowStateStreamController = Provider.autoDispose<StreamController<FlowState>>((ref) {
  final controller = StreamController<FlowState>();

  controller.sink.add(NormalState());

  ref.onDispose(() {
    controller.close();
  });

  return controller;
});

final flowStateStreamProvider = StreamProvider.autoDispose<FlowState>((ref) {
  final sink = ref.watch(flowStateStreamController).sink;
  final stream = ref.watch(flowStateStreamController).stream;

  ref.onDispose(() => sink.close());

  return stream;
});
