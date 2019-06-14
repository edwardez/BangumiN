// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EpisodeType _$Regular = const EpisodeType._('Regular');
const EpisodeType _$GeneralNonRegular = const EpisodeType._('Unknown');
const EpisodeType _$Special = const EpisodeType._('Special');
const EpisodeType _$Opening = const EpisodeType._('Opening');
const EpisodeType _$Ending = const EpisodeType._('Ending');
const EpisodeType _$Trailer = const EpisodeType._('Trailer');
const EpisodeType _$MAD = const EpisodeType._('MAD');
const EpisodeType _$OtherNonRegular = const EpisodeType._('OtherNonRegular');

EpisodeType _$valueOf(String name) {
  switch (name) {
    case 'Regular':
      return _$Regular;
    case 'Unknown':
      return _$GeneralNonRegular;
    case 'Special':
      return _$Special;
    case 'Opening':
      return _$Opening;
    case 'Ending':
      return _$Ending;
    case 'Trailer':
      return _$Trailer;
    case 'MAD':
      return _$MAD;
    case 'OtherNonRegular':
      return _$OtherNonRegular;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EpisodeType> _$values =
    new BuiltSet<EpisodeType>(const <EpisodeType>[
  _$Regular,
  _$GeneralNonRegular,
  _$Special,
  _$Opening,
  _$Ending,
  _$Trailer,
  _$MAD,
  _$OtherNonRegular,
]);

Serializer<EpisodeType> _$episodeTypeSerializer = new _$EpisodeTypeSerializer();

class _$EpisodeTypeSerializer implements PrimitiveSerializer<EpisodeType> {
  static const Map<String, String> _toWire = const <String, String>{
    'Regular': '0',
    'Special': '1',
    'Opening': '2',
    'Ending': '3',
    'Trailer': '4',
    'MAD': '5',
    'OtherNonRegular': '6',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    '0': 'Regular',
    '1': 'Special',
    '2': 'Opening',
    '3': 'Ending',
    '4': 'Trailer',
    '5': 'MAD',
    '6': 'OtherNonRegular',
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
