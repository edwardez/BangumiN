import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Colors.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/styles/theme/CommonThemeData.dart';

final ThemeData brightBangumiPinkBlueThemeData = ThemeData(
  canvasColor: Colors.white,
  brightness: Brightness.light,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  bottomSheetTheme: muninBottomSheetThemeData(),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: defaultContainerCircularRadius),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    brightness: Brightness.light,
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black54),
  ),
  primaryColor: Colors.blue,
  // TODO: flutter by default calculates abd set it to [Brightness.dark], need to
  // verify whether [Brightness.light] meets color contrast requirement
  primaryColorBrightness: Brightness.light,
  accentColor: bangumiPink,
  toggleableActiveColor: bangumiPink,
);
