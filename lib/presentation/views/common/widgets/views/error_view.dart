import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text(message)));
}
