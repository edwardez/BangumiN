import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart'
    show BuildContext, MediaQuery, Brightness;
import 'package:munin/models/bangumi/setting/theme/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ThemeSetting.g.dart';

abstract class ThemeSetting
    implements Built<ThemeSetting, ThemeSettingBuilder> {
  ThemeSetting._();

  /// Current theme value without taking system wide theme change into account.
  @Deprecated('Prefer using [findCurrentTheme]. [currentTheme] doesn\'t take'
      'system wide theme setting into account and will be renamed in the future')
  MuninTheme get currentTheme;

  /// Actual current theme value that takes system theme change into account.
  MuninTheme findCurrentTheme(BuildContext context) {
    if (themeSwitchMode == ThemeSwitchMode.FollowSystemThemeSetting) {
      final isDarkTheme =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      return isDarkTheme
          ? preferredFollowSystemDarkTheme
          : preferredFollowSystemLightTheme;
    }

    return currentTheme;
  }

  /// If current device brightness(0~100) is smaller than this value and current
  /// `themeSwitchMode` is [ThemeSwitchMode.FollowScreenBrightness]
  /// `preferredFollowBrightnessDarkTheme` will be set as `currentTheme`
  /// Otherwise, `preferredFollowBrightnessDarkTheme` will be used
  int get preferredFollowBrightnessSwitchThreshold;

  MuninTheme get preferredFollowBrightnessLightTheme;

  MuninTheme get preferredFollowBrightnessDarkTheme;

  @nullable
  MuninTheme get preferredFollowSystemLightTheme;

  @nullable
  MuninTheme get preferredFollowSystemDarkTheme;

  ThemeSwitchMode get themeSwitchMode;

  /// Returns true if user has selected at least one hidden theme in theme options
  /// If a new [MuninTheme] class field is added to [ThemeSetting], it needs to be added
  /// to here as well.
  bool get hasSelectedHiddenTheme {
    return currentTheme.isHiddenTheme ||
        preferredFollowBrightnessLightTheme.isHiddenTheme ||
        preferredFollowBrightnessDarkTheme.isHiddenTheme;
  }

  factory ThemeSetting([updates(ThemeSettingBuilder b)]) =>
      _$ThemeSetting((b) =>
      b
        ..currentTheme = MuninTheme.BrightBangumiPinkBlue
        ..preferredFollowBrightnessSwitchThreshold = 30
        ..preferredFollowBrightnessLightTheme = MuninTheme.BrightBangumiPinkBlue
        ..preferredFollowBrightnessDarkTheme = MuninTheme.NightPureDarkBlue
        ..preferredFollowSystemLightTheme = MuninTheme.BrightBangumiPinkBlue
        ..preferredFollowSystemDarkTheme = MuninTheme.NightPureDarkBlue
        ..currentTheme = MuninTheme.BrightBangumiPinkBlue
        ..themeSwitchMode = ThemeSwitchMode.FollowSystemThemeSetting
        ..update(updates));

  static void _initializeBuilder(ThemeSettingBuilder b) => b
    ..preferredFollowSystemLightTheme = MuninTheme.BrightBangumiPinkBlue
    ..preferredFollowSystemDarkTheme = MuninTheme.NightPureDarkBlue
    ..themeSwitchMode = ThemeSwitchMode.FollowSystemThemeSetting;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ThemeSetting.serializer, this));
  }

  static ThemeSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        ThemeSetting.serializer, json.decode(jsonString));
  }

  static Serializer<ThemeSetting> get serializer => _$themeSettingSerializer;
}
