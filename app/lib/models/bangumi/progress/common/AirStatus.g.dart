// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AirStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AirStatus _$Aired = const AirStatus._('Aired');
const AirStatus _$OnAir = const AirStatus._('OnAir');
const AirStatus _$NotAired = const AirStatus._('NotAired');
const AirStatus _$Unknown = const AirStatus._('Unknown');

AirStatus _$valueOf(String name) {
  switch (name) {
    case 'Aired':
      return _$Aired;
    case 'OnAir':
      return _$OnAir;
    case 'NotAired':
      return _$NotAired;
    case 'Unknown':
      return _$Unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AirStatus> _$values = new BuiltSet<AirStatus>(const <AirStatus>[
  _$Aired,
  _$OnAir,
  _$NotAired,
  _$Unknown,
]);

Serializer<AirStatus> _$airStatusSerializer = new _$AirStatusSerializer();

class _$AirStatusSerializer implements PrimitiveSerializer<AirStatus> {
  static const Map<String, String> _toWire = const <String, String>{
    'Aired': 'Air',
    'OnAir': 'Today',
    'NotAired': 'NA',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    'Air': 'Aired',
    'Today': 'OnAir',
    'NA': 'NotAired',
  };

  @override
  final Iterable<Type> types = const <Type>[AirStatus];
  @override
  final String wireName = 'AirStatus';

  @override
  Object serialize(Serializers serializers, AirStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirStatus.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
