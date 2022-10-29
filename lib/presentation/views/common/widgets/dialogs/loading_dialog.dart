import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
