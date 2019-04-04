// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CollectionStatus _$Wish = const CollectionStatus._('Wish');
const CollectionStatus _$Collect = const CollectionStatus._('Collect');
const CollectionStatus _$Do = const CollectionStatus._('Do');
const CollectionStatus _$OnHold = const CollectionStatus._('OnHold');
const CollectionStatus _$Dropped = const CollectionStatus._('Dropped');
const CollectionStatus _$Untouched = const CollectionStatus._('Untouched');

CollectionStatus _$valueOf(String name) {
  switch (name) {
    case 'Wish':
      return _$Wish;
    case 'Collect':
      return _$Collect;
    case 'Do':
      return _$Do;
    case 'OnHold':
      return _$OnHold;
    case 'Dropped':
      return _$Dropped;
    case 'Untouched':
      return _$Untouched;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<CollectionStatus> _$values =
    new BuiltSet<CollectionStatus>(const <CollectionStatus>[
  _$Wish,
  _$Collect,
  _$Do,
  _$OnHold,
  _$Dropped,
  _$Untouched,
]);

Serializer<CollectionStatus> _$collectionStatusSerializer =
    new _$CollectionStatusSerializer();

class _$CollectionStatusSerializer
    implements PrimitiveSerializer<CollectionStatus> {
  static const Map<String, String> _toWire = const <String, String>{
    'Wish': 'wish',
    'Collect': 'collect',
    'Do': 'do',
    'OnHold': 'on_hold',
    'Dropped': 'dropped',
    'Untouched': 'untouched',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    'wish': 'Wish',
    'collect': 'Collect',
    'do': 'Do',
    'on_hold': 'OnHold',
    'dropped': 'Dropped',
    'untouched': 'Untouched',
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