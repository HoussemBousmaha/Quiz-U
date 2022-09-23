import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const otp = "0000";
const kLoginUrl = "https://quizu.okoul.com/Login";
const kAuthTokenUrl = "https://quizu.okoul.com/Token";
const kUserNameUrl = "https://quizu.okoul.com/Name";
const kUserInfoUrl = "https://quizu.okoul.com/UserInfo";

const countryPicker = FlCountryCodePicker();

const kHomeScreenRoute = '/home-screen/';
const kLoginScreenRoute = '/login-screen/';
const kUserNameScreenRoute = '/userName-screen/';
const kProfileScreenRoute = '/profile-screen/';
const kConfirmOtpScreenRoute = '/confirm-otp-screen/';

const kAppBackgroundColor = Color(0xFFEFF6FE);

const kTextFeildFillColor = Color(0xFFDEE9F5);
const kPrimaryTextFieldBorderColor = Colors.white;
const kSecondaryTextFieldBorderColor = kTextFeildFillColor;

const kInactiveIconColor = kTextFeildFillColor;
const kActiveIconColor = kPrimaryTextColor;

const kHeadLineTextColor = Colors.black;
const kPrimaryTextColor = Color(0xFF4852A5);
final kSecondaryTextColor = kPrimaryTextColor.withOpacity(0.4);

const kPrimaryButtonColor = Color(0xFF5B61FE);

const kSuccessGreenColor = Color(0xFF42B4A5);
const kErrorRedColor = Color(0xFFE94E4F);

final kHeadLineTextStyle = TextStyle(
  color: kHeadLineTextColor,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.pacifico().fontFamily,
  fontSize: 40,
);

final kPrimaryTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: GoogleFonts.lato().fontFamily,
);