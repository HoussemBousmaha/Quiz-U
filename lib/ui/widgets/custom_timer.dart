import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/controllers/providers.dart';
import 'package:quiz_u/controllers/utils.dart';

class CustomTimer extends HookConsumerWidget {
  const CustomTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(duration: Duration(seconds: kDefaultQuizTime.toInt()));
    final angleAnimation = Tween<double>(begin: 0, end: math.pi * 2).animate(controller);
    final timeAnimation = Tween<double>(begin: kDefaultQuizTime.toDouble(), end: 0).animate(controller);

    final isQuizStarted = ref.watch(isQuizStartedProvider);

    useEffect(() {
      if (isQuizStarted) {
        controller.forward();
        angleAnimation.addListener(() {
          ref.read(angleProvider.notifier).state = angleAnimation.value;
        });
        timeAnimation.addListener(() {
          // print('${timeAnimation.value}');
          ref.read(timeProvider.notifier).state = timeAnimation.value;
        });
      } else {
        controller.stop();
      }

      return null;
    }, [isQuizStarted]);

    return CustomPaint(
      painter: TimerPainter(ref.watch(angleProvider)),
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: Text(intToTimeLeft(ref.watch(timeProvider).toInt())),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double angle;

  TimerPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final ringPainter = Paint()
      ..color = kPrimaryTextColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    final circlePainter = Paint()..color = kPrimaryButtonColor.withOpacity(0.2);
    final backgroudRingPainter = Paint()
      ..color = kPrimaryTextColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      -math.pi / 2,
      angle,
      false,
      ringPainter,
    );
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      0,
      math.pi * 2,
      false,
      backgroudRingPainter,
    );

    canvas.drawCircle(center, size.width * 0.3, circlePainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
