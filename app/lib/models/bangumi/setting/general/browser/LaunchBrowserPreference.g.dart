// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LaunchBrowserPreference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LaunchBrowserPreference _$Default =
    const LaunchBrowserPreference._('DefaultInApp');
const LaunchBrowserPreference _$DefaultExternal =
    const LaunchBrowserPreference._('DefaultExternal');

LaunchBrowserPreference _$valueOf(String name) {
  switch (name) {
    case 'DefaultInApp':
      return _$Default;
    case 'DefaultExternal':
      return _$DefaultExternal;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<LaunchBrowserPreference> _$values =
    new BuiltSet<LaunchBrowserPreference>(const <LaunchBrowserPreference>[
  _$Default,
  _$DefaultExternal,
]);

Serializer<LaunchBrowserPreference> _$launchBrowserPreferenceSerializer =
    new _$LaunchBrowserPreferenceSerializer();

class _$LaunchBrowserPreferenceSerializer
    implements PrimitiveSerializer<LaunchBrowserPreference> {
  @override
  final Iterable<Type> types = const <Type>[LaunchBrowserPreference];
  @override
  final String wireName = 'LaunchBrowserPreference';

  @override
  Object serialize(Serializers serializers, LaunchBrowserPreference object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  LaunchBrowserPreference deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LaunchBrowserPreference.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
