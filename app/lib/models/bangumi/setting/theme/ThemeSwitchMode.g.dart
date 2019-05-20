// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThemeSwitchMode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ThemeSwitchMode _$Manual = const ThemeSwitchMode._('Manual');
const ThemeSwitchMode _$FollowScreenBrightness =
    const ThemeSwitchMode._('FollowScreenBrightness');

ThemeSwitchMode _$valueOf(String name) {
  switch (name) {
    case 'Manual':
      return _$Manual;
    case 'FollowScreenBrightness':
      return _$FollowScreenBrightness;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ThemeSwitchMode> _$values =
    new BuiltSet<ThemeSwitchMode>(const <ThemeSwitchMode>[
  _$Manual,
  _$FollowScreenBrightness,
]);

Serializer<ThemeSwitchMode> _$themeSwitchModeSerializer =
    new _$ThemeSwitchModeSerializer();

class _$ThemeSwitchModeSerializer
    implements PrimitiveSerializer<ThemeSwitchMode> {
  @override
  final Iterable<Type> types = const <Type>[ThemeSwitchMode];
  @override
  final String wireName = 'ThemeSwitchMode';

  @override
  Object serialize(Serializers serializers, ThemeSwitchMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ThemeSwitchMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ThemeSwitchMode.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
