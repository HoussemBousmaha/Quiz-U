import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    Key? key,
    required this.onPressed,
    required this.style,
    this.margin,
    this.padding,
    this.height = 55,
    this.width = double.infinity,
    this.borderRadius,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double width;
  final double height;
  final TextStyle style;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String text;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 3),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF5B61FE), foregroundColor: Colors.white, padding: padding),
          onPressed: onPressed,
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }
}
