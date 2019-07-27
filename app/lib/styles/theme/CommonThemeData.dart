import 'package:flutter/material.dart';

BottomSheetThemeData muninBottomSheetThemeData({pureDartTheme = false}) {
  return BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        topRight: Radius.circular(4.0),
      ),
    ),
    elevation: 4.0,
    backgroundColor: pureDartTheme ? Colors.grey[850] : null,
  );
}
