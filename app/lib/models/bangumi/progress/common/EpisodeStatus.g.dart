// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EpisodeStatus _$Wish = const EpisodeStatus._('Wish');
const EpisodeStatus _$Completed = const EpisodeStatus._('Completed');
const EpisodeStatus _$Dropped = const EpisodeStatus._('Dropped');
const EpisodeStatus _$Pristine = const EpisodeStatus._('Pristine');
const EpisodeStatus _$Unknown = const EpisodeStatus._('Unknown');

EpisodeStatus _$valueOf(String name) {
  switch (name) {
    case 'Wish':
      return _$Wish;
    case 'Completed':
      return _$Completed;
    case 'Dropped':
      return _$Dropped;
    case 'Pristine':
      return _$Pristine;
    case 'Unknown':
      return _$Unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EpisodeStatus> _$values =
    new BuiltSet<EpisodeStatus>(const <EpisodeStatus>[
  _$Wish,
  _$Completed,
  _$Dropped,
  _$Pristine,
  _$Unknown,
]);

Serializer<EpisodeStatus> _$episodeStatusSerializer =
    new _$EpisodeStatusSerializer();

class _$EpisodeStatusSerializer implements PrimitiveSerializer<EpisodeStatus> {
  static const Map<String, String> _toWire = const <String, String>{
    'Wish': '1',
    'Completed': '2',
    'Dropped': '3',
    'Pristine': '9999',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    '1': 'Wish',
    '2': 'Completed',
    '3': 'Dropped',
    '9999': 'Pristine',
  };

  @override
  final Iterable<Type> types = const <Type>[EpisodeStatus];
  @override
  final String wireName = 'EpisodeStatus';

  @override
  Object serialize(Serializers serializers, EpisodeStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EpisodeStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EpisodeStatus.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
