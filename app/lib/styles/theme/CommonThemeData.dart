import 'package:flutter/material.dart';

BottomSheetThemeData muninBottomSheetThemeData({pureDartTheme = false}) {
  return BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    elevation: 5.0,
    backgroundColor: pureDartTheme ? Colors.grey[850] : null,
  );
}
