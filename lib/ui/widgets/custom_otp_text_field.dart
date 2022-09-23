import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:quiz_u/constants.dart';

class CustomOtpTextField extends StatelessWidget {
  const CustomOtpTextField({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);
  final Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      autoFocus: true,
      numberOfFields: 4,
      cursorColor: kPrimaryButtonColor,
      borderColor: Colors.white,
      enabledBorderColor: kPrimaryTextFieldBorderColor,
      focusedBorderColor: kTextFeildFillColor,
      fieldWidth: 60,
      styles: const [
        TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
        TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
        TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
        TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: 25),
      ],
      filled: true,
      fillColor: kTextFeildFillColor,
      showFieldAsBox: true,
      onSubmit: onSubmit,
    );
  }
}
