import 'package:flutter/material.dart';

class SizeConfig {
  static Size? size;
  static const double deisgnHeight = 880;
  static const double deisgnWidth = 380;

  static void init(BuildContext context) => size = MediaQuery.of(context).size;

  static double height(double height) {
    final ratio = (size != null ? (size!.height / deisgnHeight) : 1).toDouble();

    return height * ratio;
  }

  static double width(double width) {
    final ratio = (size != null ? (size!.width / deisgnWidth) : 1).toDouble();

    return width * ratio;
  }

  static Widget addVerticalSpace(double inputHeight) => SizedBox(height: height(inputHeight));
  static Widget addHorizontalSpace(double inputWidth) => SizedBox(width: width(inputWidth));
}
