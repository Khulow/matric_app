import 'package:flutter/material.dart';
import 'package:matric_app/miscellaneous/constants/colors.dart';
import 'package:matric_app/miscellaneous/constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

//light theme for buttons
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: tWhiteColor,
      backgroundColor: tSecondaryColor,
      side: const BorderSide(color: tSecondaryColor),
      //use symmetric so that the button is reponsive
      padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

//dark theme for buttons
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: tSecondaryColor,
      backgroundColor: tWhiteColor,
      side: const BorderSide(color: tSecondaryColor),
      //use symmetric so that the button is reponsive
      padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );
}
