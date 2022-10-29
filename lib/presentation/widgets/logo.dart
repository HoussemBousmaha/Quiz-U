import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'QuizU',
      style: TextStyle(
        color: ColorManager.black,
        fontFamily: GoogleFonts.pacifico().fontFamily,
        fontSize: FontSize.s40,
      ),
    );
  }
}
