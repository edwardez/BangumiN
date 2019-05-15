import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Font.dart';

final ThemeData nightDeepGreyBlueThemeData = ThemeData(
  brightness: Brightness.dark,
  typography: typography,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  sliderTheme: SliderThemeData.fromPrimaryColors(
    primaryColor: Colors.lightBlueAccent,
    primaryColorDark: Colors.lightBlueAccent.shade700,
    valueIndicatorTextStyle: ThemeData().textTheme.body2,
    primaryColorLight: Colors.lightBlueAccent.shade100,
  ),
  accentColor: Colors.lightBlueAccent,
);