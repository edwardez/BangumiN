// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreferredLaunchNavTab.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PreferredLaunchNavTab _$Timeline =
    const PreferredLaunchNavTab._('Timeline');
const PreferredLaunchNavTab _$Progress =
    const PreferredLaunchNavTab._('Progress');
const PreferredLaunchNavTab _$Discussion =
    const PreferredLaunchNavTab._('Discussion');
const PreferredLaunchNavTab _$HomePage =
    const PreferredLaunchNavTab._('HomePage');

PreferredLaunchNavTab _$valueOf(String name) {
  switch (name) {
    case 'Timeline':
      return _$Timeline;
    case 'Progress':
      return _$Progress;
    case 'Discussion':
      return _$Discussion;
    case 'HomePage':
      return _$HomePage;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PreferredLaunchNavTab> _$values =
    new BuiltSet<PreferredLaunchNavTab>(const <PreferredLaunchNavTab>[
  _$Timeline,
  _$Progress,
  _$Discussion,
  _$HomePage,
]);

Serializer<PreferredLaunchNavTab> _$preferredLaunchNavTabSerializer =
    new _$PreferredLaunchNavTabSerializer();

class _$PreferredLaunchNavTabSerializer
    implements PrimitiveSerializer<PreferredLaunchNavTab> {
  @override
  final Iterable<Type> types = const <Type>[PreferredLaunchNavTab];
  @override
  final String wireName = 'PreferredLaunchNavTab';

  @override
  Object serialize(Serializers serializers, PreferredLaunchNavTab object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PreferredLaunchNavTab deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PreferredLaunchNavTab.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
