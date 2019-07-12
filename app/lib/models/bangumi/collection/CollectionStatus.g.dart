// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CollectionStatus _$Wish = const CollectionStatus._('Wish');
const CollectionStatus _$Completed = const CollectionStatus._('Completed');
const CollectionStatus _$InProgress = const CollectionStatus._('InProgress');
const CollectionStatus _$OnHold = const CollectionStatus._('OnHold');
const CollectionStatus _$Dropped = const CollectionStatus._('Dropped');
const CollectionStatus _$Pristine = const CollectionStatus._('Pristine');
const CollectionStatus _$Unknown = const CollectionStatus._('Unknown');

CollectionStatus _$valueOf(String name) {
  switch (name) {
    case 'Wish':
      return _$Wish;
    case 'Completed':
      return _$Completed;
    case 'InProgress':
      return _$InProgress;
    case 'OnHold':
      return _$OnHold;
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

final BuiltSet<CollectionStatus> _$values =
    new BuiltSet<CollectionStatus>(const <CollectionStatus>[
  _$Wish,
  _$Completed,
  _$InProgress,
  _$OnHold,
  _$Dropped,
  _$Pristine,
  _$Unknown,
]);

Serializer<CollectionStatus> _$collectionStatusSerializer =
    new _$CollectionStatusSerializer();

class _$CollectionStatusSerializer
    implements PrimitiveSerializer<CollectionStatus> {
  static const Map<String, String> _toWire = const <String, String>{
    'Wish': 'wish',
    'Completed': 'collect',
    'InProgress': 'do',
    'OnHold': 'on_hold',
    'Dropped': 'dropped',
    'Pristine': 'untouched',
    'Unknown': 'unknown',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    'wish': 'Wish',
    'collect': 'Completed',
    'do': 'InProgress',
    'on_hold': 'OnHold',
    'dropped': 'Dropped',
    'untouched': 'Pristine',
    'unknown': 'Unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[CollectionStatus];
  @override
  final String wireName = 'type';

  @override
  Object serialize(Serializers serializers, CollectionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CollectionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CollectionStatus.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
