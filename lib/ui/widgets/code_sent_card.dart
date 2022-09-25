import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_u/constants.dart';
import 'package:quiz_u/size_config.dart';

class CodeSendCard extends StatelessWidget {
  const CodeSendCard({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SizedBox(
      width: SizeConfig.width(225),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: SizeConfig.width(15),
            right: SizeConfig.width(30),
            bottom: SizeConfig.height(5),
            top: SizeConfig.height(5),
            child: Container(
              height: SizeConfig.height(100),
              decoration: BoxDecoration(color: kPrimaryButtonColor, borderRadius: BorderRadius.circular(5)),
              alignment: const Alignment(0, 0),
              child: Text(
                'OTP is 0000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.height(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              height: SizeConfig.height(30),
              width: SizeConfig.width(30),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5FF1BD),
              ),
              child: Icon(
                FontAwesomeIcons.check,
                color: Colors.white,
                size: SizeConfig.width(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
