// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeUpdateType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EpisodeUpdateType _$Wish = const EpisodeUpdateType._('Wish');
const EpisodeUpdateType _$Collect = const EpisodeUpdateType._('Collect');
const EpisodeUpdateType _$CollectUntil =
    const EpisodeUpdateType._('CollectUntil');
const EpisodeUpdateType _$Drop = const EpisodeUpdateType._('Drop');
const EpisodeUpdateType _$Remove = const EpisodeUpdateType._('Remove');

EpisodeUpdateType _$valueOf(String name) {
  switch (name) {
    case 'Wish':
      return _$Wish;
    case 'Collect':
      return _$Collect;
    case 'CollectUntil':
      return _$CollectUntil;
    case 'Drop':
      return _$Drop;
    case 'Remove':
      return _$Remove;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EpisodeUpdateType> _$values =
    new BuiltSet<EpisodeUpdateType>(const <EpisodeUpdateType>[
  _$Wish,
  _$Collect,
  _$CollectUntil,
  _$Drop,
  _$Remove,
]);

Serializer<EpisodeUpdateType> _$episodeUpdateTypeSerializer =
    new _$EpisodeUpdateTypeSerializer();

class _$EpisodeUpdateTypeSerializer
    implements PrimitiveSerializer<EpisodeUpdateType> {
  @override
  final Iterable<Type> types = const <Type>[EpisodeUpdateType];
  @override
  final String wireName = 'EpisodeUpdateType';

  @override
  Object serialize(Serializers serializers, EpisodeUpdateType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EpisodeUpdateType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EpisodeUpdateType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
