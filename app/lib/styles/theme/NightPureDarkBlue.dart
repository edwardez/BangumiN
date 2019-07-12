import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/styles/theme/Font.dart';

final ThemeData nightPureDarkBlueThemeData = ThemeData(
  brightness: Brightness.dark,
  typography: typography,
  canvasColor: Colors.black,
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: defaultContainerCircularRadius),
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
  ),
  sliderTheme: SliderThemeData.fromPrimaryColors(
    primaryColor: Colors.lightBlueAccent,
    primaryColorDark: Colors.lightBlueAccent.shade700,
    valueIndicatorTextStyle: ThemeData().textTheme.body2,
    primaryColorLight: Colors.lightBlueAccent.shade100,
  ),
  dividerColor: Colors.grey,
  accentColor: Colors.lightBlueAccent,
  toggleableActiveColor: Colors.lightBlueAccent,
);
