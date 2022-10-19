import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.style,
    this.controller,
    this.keyBoardType,
    this.borderColor = kPrimaryTextFieldBorderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 45.0),
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.focus,
    this.align = TextAlign.start,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final Color borderColor;
  final EdgeInsets padding;
  final String label;
  final TextStyle style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focus;
  final TextAlign align;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        enableInteractiveSelection: false,
        focusNode: focus,
        keyboardType: keyBoardType,
        controller: controller,
        style: style,
        textAlign: align,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          prefixIcon: prefixIcon,
          labelText: label,
          suffixIcon: suffixIcon,
          labelStyle: TextStyle(color: kSecondaryTextColor),
          floatingLabelStyle: TextStyle(color: kSecondaryTextColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 2)),
          filled: true,
          fillColor: kTextFeildFillColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
