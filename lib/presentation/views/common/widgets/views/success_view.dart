import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  const SuccessView(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text(message)));
}
