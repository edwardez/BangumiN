import 'package:flutter/material.dart';

class BangumiPinkBlue {
  static const _bangumiPinkPrimaryValue = 0xFFF09199;

  static const MaterialColor bangumiPink = const MaterialColor(
    _bangumiPinkPrimaryValue,
    const <int, Color>{
      50: const Color(0xFFFFE9EE),
      100: const Color(0xFFFFC8D2),
      200: const Color(0xFFF09199),
      300: const Color(0xFFE56572),
      400: const Color(0xFFEE3D50),
      500: const Color(0xFFF32037),
      600: const Color(0xFFE41036),
      700: const Color(0xFFD20030),
      800: const Color(0xFFC50029),
      900: const Color(0xFFB6001D),
    },
  );

  final data = ThemeData(
    canvasColor: Colors.white,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      brightness: Brightness.light,
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black54),
      textTheme: Typography.blackMountainView,
    ),
    primarySwatch: Colors.blue,
    accentColor: bangumiPink,
  );
}
