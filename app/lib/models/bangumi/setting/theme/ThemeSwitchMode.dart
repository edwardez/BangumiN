import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ThemeSwitchMode.g.dart';

class ThemeSwitchMode extends EnumClass {
  @BuiltValueEnumConst(fallback: true)
  static const ThemeSwitchMode Manual = _$Manual;

  static const ThemeSwitchMode FollowScreenBrightness =
      _$FollowScreenBrightness;

  static const ThemeSwitchMode FollowSystemThemeSetting =
      _$FollowSystemThemeSetting;

  const ThemeSwitchMode._(String name) : super(name);

  static BuiltSet<ThemeSwitchMode> get values => _$values;

  static ThemeSwitchMode valueOf(String name) => _$valueOf(name);

  static Serializer<ThemeSwitchMode> get serializer =>
      _$themeSwitchModeSerializer;

  static ThemeSwitchMode fromWiredName(String wiredName) {
    return serializers.deserializeWith(ThemeSwitchMode.serializer, wiredName);
  }
}
