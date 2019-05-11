// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EpisodeType _$MainEpisode = const EpisodeType._('RegularEpisode');
const EpisodeType _$NonMainEpisode = const EpisodeType._('NonRegularEpisode');

EpisodeType _$valueOf(String name) {
  switch (name) {
    case 'RegularEpisode':
      return _$MainEpisode;
    case 'NonRegularEpisode':
      return _$NonMainEpisode;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EpisodeType> _$values =
    new BuiltSet<EpisodeType>(const <EpisodeType>[
  _$MainEpisode,
  _$NonMainEpisode,
]);

Serializer<EpisodeType> _$episodeTypeSerializer = new _$EpisodeTypeSerializer();

class _$EpisodeTypeSerializer implements PrimitiveSerializer<EpisodeType> {
  static const Map<String, String> _toWire = const <String, String>{
    'RegularEpisode': '0',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    '0': 'RegularEpisode',
  };

  @override
  final Iterable<Type> types = const <Type>[EpisodeType];
  @override
  final String wireName = 'EpisodeType';

  @override
  Object serialize(Serializers serializers, EpisodeType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EpisodeType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EpisodeType.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
