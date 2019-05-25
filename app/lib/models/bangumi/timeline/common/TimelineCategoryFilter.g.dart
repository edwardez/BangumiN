// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimelineCategoryFilter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TimelineCategoryFilter _$AllFeeds =
    const TimelineCategoryFilter._('AllFeeds');
const TimelineCategoryFilter _$PublicMessage =
    const TimelineCategoryFilter._('PublicMessage');
const TimelineCategoryFilter _$Collection =
    const TimelineCategoryFilter._('Collection');
const TimelineCategoryFilter _$Progress =
    const TimelineCategoryFilter._('Progress');
const TimelineCategoryFilter _$Blog = const TimelineCategoryFilter._('Blog');
const TimelineCategoryFilter _$Mono = const TimelineCategoryFilter._('Mono');
const TimelineCategoryFilter _$FriendShip =
    const TimelineCategoryFilter._('FriendShip');
const TimelineCategoryFilter _$ProgressUpdate =
    const TimelineCategoryFilter._('Group');
const TimelineCategoryFilter _$Wiki = const TimelineCategoryFilter._('Wiki');
const TimelineCategoryFilter _$Catalog =
    const TimelineCategoryFilter._('Catalog');
const TimelineCategoryFilter _$Doujin =
    const TimelineCategoryFilter._('Doujin');

TimelineCategoryFilter _$valueOf(String name) {
  switch (name) {
    case 'AllFeeds':
      return _$AllFeeds;
    case 'PublicMessage':
      return _$PublicMessage;
    case 'Collection':
      return _$Collection;
    case 'Progress':
      return _$Progress;
    case 'Blog':
      return _$Blog;
    case 'Mono':
      return _$Mono;
    case 'FriendShip':
      return _$FriendShip;
    case 'Group':
      return _$ProgressUpdate;
    case 'Wiki':
      return _$Wiki;
    case 'Catalog':
      return _$Catalog;
    case 'Doujin':
      return _$Doujin;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TimelineCategoryFilter> _$values =
    new BuiltSet<TimelineCategoryFilter>(const <TimelineCategoryFilter>[
  _$AllFeeds,
  _$PublicMessage,
  _$Collection,
  _$Progress,
  _$Blog,
  _$Mono,
  _$FriendShip,
  _$ProgressUpdate,
  _$Wiki,
  _$Catalog,
  _$Doujin,
]);

Serializer<TimelineCategoryFilter> _$timelineCategoryFilterSerializer =
    new _$TimelineCategoryFilterSerializer();

class _$TimelineCategoryFilterSerializer
    implements PrimitiveSerializer<TimelineCategoryFilter> {
  @override
  final Iterable<Type> types = const <Type>[TimelineCategoryFilter];
  @override
  final String wireName = 'TimelineCategoryFilter';

  @override
  Object serialize(Serializers serializers, TimelineCategoryFilter object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TimelineCategoryFilter deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TimelineCategoryFilter.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
