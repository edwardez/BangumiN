import 'package:flutter/material.dart';

/// A theme that specifies a small button
/// Note: it doesn't align with Material standard spec and should be used
/// as less as possible
/// If height is not supplied, default value is twice the height of body1 fontSize
ButtonThemeData smallButtonTheme(
  BuildContext context, {
  double minWidth = 48.0,
  double height,
  padding: const EdgeInsets.all(0),
}) {
  ButtonThemeData defaultButtonTheme = Theme.of(context).buttonTheme;

  ButtonThemeData modifiedButtonTheme = defaultButtonTheme.copyWith(
    minWidth: minWidth,
    height: height ?? Theme.of(context).textTheme.body1.fontSize * 2,
    padding: padding,
  );

  return modifiedButtonTheme;
}
