import 'package:flutter/material.dart';
import 'package:matric_app/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:matric_app/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:matric_app/utils/theme/widget_themes/text_field_theme.dart';
import 'package:matric_app/utils/theme/widget_themes/text_themes.dart';

class TAppTheme {
  TAppTheme._();// TO AVOID CREATING INSTANCES

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      // to dynamically change the color of the outlinedbutton when the theme changes
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark, 
      textTheme: TTextTheme.darkTextTheme,
      // to dynamically change the color of the outlinedbutton when the theme changes
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme);
      
}
