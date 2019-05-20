import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:munin/styles/theme/BrightBlueBangumiPink.dart';
import 'package:munin/styles/theme/BrightIonBrownBlue.dart';
import 'package:munin/styles/theme/BrightNatoriPinkBrown.dart';
import 'package:munin/styles/theme/NightDeepGreyBlue.dart';
import 'package:munin/styles/theme/NightPureDarkBlue.dart';

part 'MuninTheme.g.dart';

class MuninTheme extends EnumClass {
  static const MuninTheme BrightBangumiPinkBlue = _$BrightBangumiPinkBlue;

  static const MuninTheme BrightIon = _$BrightIon;

  static const MuninTheme BrightNatori = _$BrightNatori;

  static const MuninTheme NightPureDarkBlue = _$NightPureDarkBlue;

  static const MuninTheme NightDeepGreyBlue = _$NightDeepGreyBlue;

  bool get isLightTheme {
    assert(_isLightTheme(this) || _isDarkTheme(this),
        '$this must be either a light or dark theme');

    return _isLightTheme(this);
  }

  bool _isLightTheme(MuninTheme theme) {
    return theme == MuninTheme.BrightBangumiPinkBlue ||
        theme == MuninTheme.BrightIon ||
        theme == MuninTheme.BrightNatori;
  }

  bool get isDarkTheme {
    assert(_isLightTheme(this) || _isDarkTheme(this),
        '$this must be either a light or dark theme');

    return _isDarkTheme(this);
  }

  bool _isDarkTheme(MuninTheme theme) {
    return theme == NightPureDarkBlue || this == NightDeepGreyBlue;
  }

  bool get isHiddenTheme {
    return this == MuninTheme.BrightIon || this == MuninTheme.BrightNatori;
  }

  ThemeData get themeData {
    switch (this) {
      case BrightIon:
        return brightIonBrownBlueThemeData;
      case BrightNatori:
        return brightNatoriPinkBrownThemeData;
      case BrightBangumiPinkBlue:
        return brightBangumiPinkBlueThemeData;
      case NightPureDarkBlue:
        return nightPureDarkBlueThemeData;
      case NightDeepGreyBlue:
        return nightDeepGreyBlueThemeData;
      default:
        assert(false, '$this must have a pre-assigned ThemeData');
        return brightBangumiPinkBlueThemeData;
    }
  }

  String get chineseName {
    switch (this) {
      case BrightBangumiPinkBlue:
        return '默认';
      case BrightIon:
        return 'Ion';
      case BrightNatori:
        return 'Natori';
      case NightPureDarkBlue:
        return '纯黑';
      case NightDeepGreyBlue:
        return '深灰';
      default:
        assert(false, '$this must have a vaid chineseName');
        return '-';
    }
  }

  static List<MuninTheme> allAvailableThemes(bool listHiddenTheme) {
    return availableLightThemes(listHiddenTheme)..addAll(availableDarkThemes());
  }

  static List<MuninTheme> availableLightThemes(bool showHiddenTheme) {
    List<MuninTheme> availableLightThemes = [
      MuninTheme.BrightBangumiPinkBlue,
    ];

    if (showHiddenTheme) {
      availableLightThemes.addAll([
        MuninTheme.BrightIon,
        MuninTheme.BrightNatori,
      ]);
    }

    return availableLightThemes;
  }

  static List<MuninTheme> availableDarkThemes() {
    return [
      MuninTheme.NightDeepGreyBlue,
      MuninTheme.NightPureDarkBlue,
    ];
  }

  const MuninTheme._(String name) : super(name);

  static BuiltSet<MuninTheme> get values => _$values;

  static MuninTheme valueOf(String name) => _$valueOf(name);

  static Serializer<MuninTheme> get serializer => _$muninThemeSerializer;

  static MuninTheme fromWiredName(String wiredName) {
    return serializers.deserializeWith(MuninTheme.serializer, wiredName);
  }
}
