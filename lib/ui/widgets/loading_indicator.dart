import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.width * 0.7,
        width: size.width * 0.7,
        child: const LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          strokeWidth: 8,
          colors: [Colors.blueAccent, Colors.amber],
        ),
      ),
    );
  }
}
