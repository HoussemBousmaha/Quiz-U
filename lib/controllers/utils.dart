import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum AuthState { loggedIn, signedUp }

void useAsyncEffect(Future<Dispose?> Function() effect, [List<Object?>? keys]) {
  useEffect(() {
    final disposeFuture = Future.microtask(effect);
    return () => disposeFuture.then((dispose) => dispose?.call());
  }, keys);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

  String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

  String result = "$minuteLeft:$secondsLeft";

  return result;
}
