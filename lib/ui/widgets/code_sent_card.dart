import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_u/constants.dart';

class CodeSendCard extends StatelessWidget {
  const CodeSendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 15,
            right: 0,
            bottom: 0,
            child: Container(
              height: 110,
              width: 280,
              decoration: BoxDecoration(
                color: kPrimaryButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: const Alignment(0, 0),
              child: const Text(
                'OTP is 0000',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5FF1BD),
              ),
              child: const Icon(FontAwesomeIcons.check, color: Colors.white, size: 15),
            ),
          ),
        ],
      ),
    );
  }
}
