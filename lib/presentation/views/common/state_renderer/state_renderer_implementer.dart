import 'package:flutter/material.dart';

import 'state_renderer.dart';

abstract class FlowState {
  StateRendererType get getStateRendererType;
  String get getMessage;
  String get getTitle;
}

// Loading State (Popup, Full Screen)
class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  LoadingState({required this.stateRendererType, this.message = 'Loading'});

  @override
  String get getMessage => message;

  @override
  String get getTitle => '';

  @override
  StateRendererType get getStateRendererType => stateRendererType;
}

// Error State (Popup, Full Screen)
class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  ErrorState({required this.stateRendererType, required this.message});

  @override
  String get getMessage => message;

  @override
  String get getTitle => '';

  @override
  StateRendererType get getStateRendererType => stateRendererType;
}

// Content State (Popup, Full Screen)
class ContentState extends FlowState {
  ContentState();

  @override
  String get getMessage => '';

  @override
  String get getTitle => '';

  @override
  StateRendererType get getStateRendererType => StateRendererType.contentScreenState;
}

// Empty State (Popup, Full Screen)
class EmptyState extends FlowState {
  final String message;
  EmptyState({required this.message});

  @override
  String get getMessage => message;

  @override
  String get getTitle => '';

  @override
  StateRendererType get getStateRendererType => StateRendererType.emptyScreenState;
}

// Success State (Popup, Full Screen)
class SuccessState extends FlowState {
  final StateRendererType stateRendererType;
  final String title;
  final String message;

  SuccessState({required this.stateRendererType, required this.title, required this.message});

  @override
  String get getMessage => message;

  @override
  String get getTitle => title;

  @override
  StateRendererType get getStateRendererType => stateRendererType;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreen) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType == StateRendererType.popupLoadingState) {
          // dismiss any showing dialog
          dismissDialog(context);

          //show popup dialog
          showPopup(context, getStateRendererType, getTitle, getMessage);

          // return the content ui of the screen
          return contentScreen;
        } else {
          // full screen popup state
          return StateRenderer(
            stateRendererType: getStateRendererType,
            message: getMessage,
          );
        }
      case ErrorState:
        if (getStateRendererType == StateRendererType.popupErrorState) {
          // dismiss any showing dialog
          dismissDialog(context);

          //show popup dialog
          showPopup(context, getStateRendererType, getTitle, getMessage);

          // return the content ui of the screen
          return contentScreen;
        } else {
          // full screen error state
          return StateRenderer(
            stateRendererType: getStateRendererType,
            message: getMessage,
          );
        }
      case SuccessState:
        if (getStateRendererType == StateRendererType.popupSuccess) {
          // dismiss any showing dialog
          dismissDialog(context);

          //show popup dialog
          showPopup(context, getStateRendererType, getTitle, getMessage);

          // return the content ui of the screen
          return contentScreen;
        } else {
          // full screen success state
          return StateRenderer(
            stateRendererType: getStateRendererType,
            message: getMessage,
          );
        }
      case EmptyState:
        dismissDialog(context);
        return StateRenderer(
          stateRendererType: getStateRendererType,
          message: getMessage,
        );
      case ContentState:
        // dismiss any popups
        dismissDialog(context);

        return contentScreen;

      default:
        // dismiss any popups
        dismissDialog(context);

        // default screen
        return contentScreen;
    }
  }

  void dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent == false;

  void showPopup(BuildContext context, StateRendererType stateRendererType, String title, String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          title: title,
          message: message,
        ),
      ),
    );
  }
}
