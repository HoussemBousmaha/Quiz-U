import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Text(message),
      ),
    );
  }
}
