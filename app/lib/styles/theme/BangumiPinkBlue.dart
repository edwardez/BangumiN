import 'package:flutter/foundation.dart' show defaultTargetPlatform;
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

  static TextStyle _textStyle(TextStyle base) {
    return base.copyWith(
      fontFamily: _kFontFamily,
      locale: kLocale,
      textBaseline: TextBaseline.ideographic,
    );
  }

  static TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      display4: _textStyle(base.display4),
      display3: _textStyle(base.display3),
      display2: _textStyle(base.display2),
      display1: _textStyle(base.display1),
      headline: _textStyle(base.headline),
      title: _textStyle(base.title),
      subhead: _textStyle(base.subhead),
      body2: _textStyle(base.body2),
      body1: _textStyle(base.body1),
      caption: _textStyle(base.caption),
      button: _textStyle(base.button),
      overline: _textStyle(base.overline),
    );
  }

  /// TODO: figure out a way to configure fonts without using workarounds
  /// currently approach in https://medium.com/@najeira/flutter-and-cjk-font-4e372b37083c
  /// is used
  static const Locale kLocale = const Locale('zh', '');
  static const String fontFamilyAndroid = null;
  static const String fontFamilyCupertino = 'PingFang SC';
  static final bool _android = defaultTargetPlatform == TargetPlatform.android;
  static final String _kFontFamily = _android
      ? fontFamilyAndroid
      : fontFamilyCupertino;
  static final TextTheme _whiteTextTheme = _android ? Typography
      .whiteMountainView : Typography.whiteCupertino;
  static final TextTheme _blackTextTheme = _android ? Typography
      .blackMountainView : Typography.blackCupertino;
  static final Typography typography = Typography(
    platform: defaultTargetPlatform,
    white: _textTheme(_whiteTextTheme),
    black: _textTheme(_blackTextTheme),
    englishLike: _textTheme(Typography.englishLike2014),
    dense: _textTheme(Typography.dense2014),
    tall: _textTheme(Typography.tall2014),
  );


  final data = ThemeData(
    typography: typography,
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
      textTheme: Typography.blackMountainView.copyWith(

      ),
    ),
    primarySwatch: Colors.blue,
    accentColor: bangumiPink,
  );
}
