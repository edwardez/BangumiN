import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/styles/theme/CommonThemeData.dart';

final ThemeData nightDeepGreyBlueThemeData = ThemeData(
  brightness: Brightness.dark,
  bottomSheetTheme: muninBottomSheetThemeData(),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: defaultContainerCircularRadius),
  ),
  sliderTheme: SliderThemeData.fromPrimaryColors(
    primaryColor: Colors.lightBlueAccent,
    primaryColorDark: Colors.lightBlueAccent.shade700,
    valueIndicatorTextStyle: ThemeData().textTheme.body2,
    primaryColorLight: Colors.lightBlueAccent.shade100,
  ),
  accentColor: Colors.lightBlueAccent,
  toggleableActiveColor: Colors.lightBlueAccent,
);
