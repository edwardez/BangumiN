// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimelineSource.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TimelineSource _$AllFeeds = const TimelineSource._('AllUsers');
const TimelineSource _$FriendsOnly = const TimelineSource._('FriendsOnly');
const TimelineSource _$UserProfile = const TimelineSource._('UserProfile');

TimelineSource _$valueOf(String name) {
  switch (name) {
    case 'AllUsers':
      return _$AllFeeds;
    case 'FriendsOnly':
      return _$FriendsOnly;
    case 'UserProfile':
      return _$UserProfile;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TimelineSource> _$values =
    new BuiltSet<TimelineSource>(const <TimelineSource>[
  _$AllFeeds,
  _$FriendsOnly,
  _$UserProfile,
]);

Serializer<TimelineSource> _$timelineSourceSerializer =
    new _$TimelineSourceSerializer();

class _$TimelineSourceSerializer
    implements PrimitiveSerializer<TimelineSource> {
  @override
  final Iterable<Type> types = const <Type>[TimelineSource];
  @override
  final String wireName = 'TimelineSource';

  @override
  Object serialize(Serializers serializers, TimelineSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TimelineSource deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TimelineSource.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
