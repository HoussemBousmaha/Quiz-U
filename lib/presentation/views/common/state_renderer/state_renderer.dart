import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/value_manager.dart';

enum StateRendererType {
  // popup states
  popupLoadingState,
  popupErrorState,
  popupSuccess,

  // full screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenSuccessState,

  // Empty View When We Recieve no data from API Side for List Screen
  emptyScreenState,

  // Ui of the screen
  contentScreenState,
}

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.stateRendererType,
    String? message,
    String? title,
  })  : title = title ?? AppStrings.empty,
        message = message ?? AppStrings.loading;

  final StateRendererType stateRendererType;
  final String message;
  final String title;

  @override
  Widget build(BuildContext context) => _getStateWidget(context);

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(
          context,
          [
            _getAnimatedImage(),
          ],
        );
      case StateRendererType.popupErrorState:
        return _getPopupDialog(
          context,
          [
            _getAnimatedImage(),
            SizedBox(height: AppSize.hs20),
            _getMessage(message),
            SizedBox(height: AppSize.hs20),
            _getRetryButton(context, AppStrings.ok),
          ],
        );
      case StateRendererType.popupSuccess:
        return _getPopupDialog(
          context,
          [
            _getAnimatedImage(),
            SizedBox(height: AppSize.hs20),
            _getTitle(title),
            SizedBox(height: AppSize.hs20),
            _getMessage(message),
            SizedBox(height: AppSize.hs20),
            _getRetryButton(context, AppStrings.ok),
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(),
            SizedBox(height: AppSize.hs100),
            _getMessage(message),
          ],
        );
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn(
          [
            // _getAnimatedImage(),
            SizedBox(
              height: AppSize.hs100,
              width: AppSize.ws100,
              child: Icon(Icons.error, color: ColorManager.primaryButtonColor, size: AppSize.hs100),
            ),
            SizedBox(height: AppSize.hs60),
            _getMessage(message),
            SizedBox(height: AppSize.hs20),
            _getRetryButton(context, AppStrings.retryAgain),
          ],
        );
      case StateRendererType.fullScreenSuccessState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(),
            SizedBox(height: AppSize.hs20),
            _getMessage(message),
            SizedBox(height: AppSize.hs20),
            _getRetryButton(context, AppStrings.ok),
          ],
        );
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(),
            SizedBox(height: AppSize.hs20),
            _getMessage(message),
          ],
        );
      case StateRendererType.contentScreenState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage() => SizedBox(
        height: AppSize.hs100,
        width: AppSize.ws100,
        child: const CircularProgressIndicator(color: ColorManager.primaryButtonColor),
      );

  Widget _getMessage(String message) => Text(
        message,
        style: getBoldStyle(color: ColorManager.primaryButtonColor, fontSize: FontSize.s20),
        textAlign: TextAlign.center,
      );

  Widget _getTitle(String title) => Text(
        title,
        style: getBoldStyle(color: ColorManager.primaryButtonColor, fontSize: FontSize.s24),
        textAlign: TextAlign.center,
      );

  Widget _getRetryButton(BuildContext context, String buttonText) {
    return Center(
      child: Container(
        width: AppSize.hs180,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws18),
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: Navigator.of(context).pop,
          child: Text(buttonText),
        ),
      ),
    );
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppSize.hs14))),
      elevation: AppSize.hs1,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws20, vertical: AppSize.hs28),
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.hs14)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black,
              blurRadius: AppSize.hs12,
              offset: Offset(AppSize.ws0, AppSize.hs12),
            ),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Container(
      alignment: Alignment.center,
      color: ColorManager.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
