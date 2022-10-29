import 'package:flutter/material.dart';

import 'flow_state_view.dart';

abstract class FlowState {
  StateType get stateType;
  String get message;
}

class LoadingState extends FlowState {
  @override
  final StateType stateType;
  @override
  final String message;
  LoadingState(this.stateType, this.message);
}

class ErrorState extends FlowState {
  @override
  final StateType stateType;
  @override
  final String message;
  ErrorState(this.stateType, this.message);
}

class SuccessState extends FlowState {
  @override
  final StateType stateType;
  @override
  final String message;
  SuccessState(this.stateType, this.message);
}

class NormalState extends FlowState {
  @override
  StateType get stateType => StateType.normalState;

  @override
  String get message => '';
}

extension FlowStateExtension on FlowState {
  Widget getView(BuildContext context, Widget contentView) {
    switch (runtimeType) {
      case LoadingState:
        if (stateType == StateType.fullScreenLoading) return FlowStateView(stateType, message);

        dismissDialog(context);
        showPopup(context, stateType, message);

        return contentView;

      case ErrorState:
        if (stateType == StateType.fullScreenError) return FlowStateView(stateType, message);

        dismissDialog(context);
        showPopup(context, stateType, message);

        return contentView;
      case SuccessState:
        if (stateType == StateType.fullScreenSuccess) return FlowStateView(stateType, message);

        dismissDialog(context);
        showPopup(context, stateType, message);

        return contentView;

      case NormalState:
        dismissDialog(context);
        return contentView;

      default:
        dismissDialog(context);
        return contentView;
    }
  }

  void dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent == false;

  void showPopup(BuildContext context, StateType stateType, String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => FlowStateView(stateType, message),
      ),
    );
  }
}
