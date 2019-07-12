// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RakuenFilter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RakuenTopicFilter _$Unrestricted =
    const RakuenTopicFilter._('Unrestricted');
const RakuenTopicFilter _$AllGroups = const RakuenTopicFilter._('AllGroups');
const RakuenTopicFilter _$JoinedGroups =
    const RakuenTopicFilter._('JoinedGroups');
const RakuenTopicFilter _$Subject = const RakuenTopicFilter._('Subject');
const RakuenTopicFilter _$Episode = const RakuenTopicFilter._('Episode');
const RakuenTopicFilter _$Mono = const RakuenTopicFilter._('Mono');

RakuenTopicFilter _$valueOf(String name) {
  switch (name) {
    case 'Unrestricted':
      return _$Unrestricted;
    case 'AllGroups':
      return _$AllGroups;
    case 'JoinedGroups':
      return _$JoinedGroups;
    case 'Subject':
      return _$Subject;
    case 'Episode':
      return _$Episode;
    case 'Mono':
      return _$Mono;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<RakuenTopicFilter> _$values =
    new BuiltSet<RakuenTopicFilter>(const <RakuenTopicFilter>[
  _$Unrestricted,
  _$AllGroups,
  _$JoinedGroups,
  _$Subject,
  _$Episode,
  _$Mono,
]);

Serializer<RakuenTopicFilter> _$rakuenTopicFilterSerializer =
    new _$RakuenTopicFilterSerializer();

class _$RakuenTopicFilterSerializer
    implements PrimitiveSerializer<RakuenTopicFilter> {
  @override
  final Iterable<Type> types = const <Type>[RakuenTopicFilter];
  @override
  final String wireName = 'RakuenTopicFilter';

  @override
  Object serialize(Serializers serializers, RakuenTopicFilter object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  RakuenTopicFilter deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RakuenTopicFilter.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
