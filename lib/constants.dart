import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_u/size_config.dart';

const kGenderApiKey = "5AoKZBgFj8r5e93lVetQGBQbJ7t7gR9jsPKn";

const otp = "0000";
const kLoginUrl = "https://quizu.okoul.com/Login";
const kAuthTokenUrl = "https://quizu.okoul.com/Token";
const kUserNameUrl = "https://quizu.okoul.com/Name";
const kUserInfoUrl = "https://quizu.okoul.com/UserInfo";
const kQuestionUrl = "https://quizu.okoul.com/Questions";
const kTopScoresUrl = "https://quizu.okoul.com/TopScores";
const kSaveUserScoreUrl = "https://quizu.okoul.com/Score";

const countryPicker = FlCountryCodePicker();

const kHomeScreenRoute = '/home-screen/';
const kLoginScreenRoute = '/login-screen/';
const kUserNameScreenRoute = '/userName-screen/';
const kProfileScreenRoute = '/profile-screen/';
const kConfirmOtpScreenRoute = '/confirm-otp-screen/';
const kAuthWrapperRoute = '/auth-wrapper/';
const kHomeWrapperRoute = '/home-wrapper/';
const kQuizScreenRoute = '/quiz-screen/';

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
  fontSize: SizeConfig.width(40),
);

const kPrimaryTextStyle = TextStyle(color: Colors.white);

const kDefaultDuration = 600;

const kDefaultQuizTime = 2.0;
