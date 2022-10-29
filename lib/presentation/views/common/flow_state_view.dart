import 'package:flutter/material.dart';

import 'widgets/dialogs/error_dialog.dart';
import 'widgets/dialogs/loading_dialog.dart';
import 'widgets/dialogs/success_dialog.dart';
import 'widgets/views/error_view.dart';
import 'widgets/views/loading_view.dart';
import 'widgets/views/success_view.dart';

enum StateType {
  popupLoading,
  fullScreenLoading,
  popupSuccess,
  fullScreenSuccess,
  popupError,
  fullScreenError,

  normalState,
}

class FlowStateView extends StatelessWidget {
  final StateType _stateType;
  final String message;
  const FlowStateView(this._stateType, this.message, {super.key});

  @override
  Widget build(BuildContext context) => getStateView();

  Widget getStateView() {
    switch (_stateType) {
      case StateType.popupLoading:
        return const LoadingDialog();
      case StateType.fullScreenLoading:
        return const LoadingView();

      case StateType.popupSuccess:
        return SuccessDialog(message);

      case StateType.fullScreenSuccess:
        return SuccessView(message);

      case StateType.popupError:
        return ErrorDialog(message);

      case StateType.fullScreenError:
        return ErrorView(message);

      case StateType.normalState:
        return Container();

      default:
        return Container();
    }
  }
}
