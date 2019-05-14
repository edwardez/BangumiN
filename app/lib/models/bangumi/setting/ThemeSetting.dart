import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/setting/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/ThemeSwitchMode.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ThemeSetting.g.dart';

abstract class ThemeSetting
    implements Built<ThemeSetting, ThemeSettingBuilder> {
  ThemeSetting._();

  MuninTheme get currentTheme;

  /// If current device brightness(0~100) is smaller than this value and current
  /// `themeSwitchMode` is [ThemeSwitchMode.FollowScreenBrightness]
  /// `preferredFollowBrightnessDarkTheme` will be set as `currentTheme`
  /// Otherwise, `preferredFollowBrightnessDarkTheme` will be used
  int get preferredFollowBrightnessSwitchThreshold;

  MuninTheme get preferredFollowBrightnessLightTheme;

  MuninTheme get preferredFollowBrightnessDarkTheme;

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
      _$ThemeSetting((b) => b
        ..currentTheme = MuninTheme.BrightBangumiPinkBlue
        ..preferredFollowBrightnessSwitchThreshold = 10
        ..preferredFollowBrightnessLightTheme = MuninTheme.BrightBangumiPinkBlue
        ..preferredFollowBrightnessDarkTheme = MuninTheme.NightPureDarkBlue
        ..currentTheme = MuninTheme.BrightBangumiPinkBlue
        ..themeSwitchMode = ThemeSwitchMode.Manual
        ..update(updates));

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
