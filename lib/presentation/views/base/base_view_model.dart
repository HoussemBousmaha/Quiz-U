import 'dart:async';

import 'package:rxdart/subjects.dart';

import '../common/state_renderer/state_renderer_implementer.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and function that will be used through any view model.

  final StreamController<FlowState> _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  void dispose() => _inputStateStreamController.close();

  @override
  Sink<FlowState> get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model
  void dispose(); // will be called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
