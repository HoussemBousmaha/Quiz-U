import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quiz_u/constants.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Center(
        child: SizedBox(
          height: size.width * 0.4,
          width: size.width * 0.4,
          child: const LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            strokeWidth: 8,
            colors: [kPrimaryTextColor],
          ),
        ),
      ),
    );
  }
}
