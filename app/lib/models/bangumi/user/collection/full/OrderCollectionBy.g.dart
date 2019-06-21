// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderCollectionBy.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderCollectionBy _$Rating = const OrderCollectionBy._('Rating');
const OrderCollectionBy _$CollectedTime =
    const OrderCollectionBy._('CollectedTime');
const OrderCollectionBy _$ReleaseDate =
    const OrderCollectionBy._('ReleaseDate');
const OrderCollectionBy _$Alphabetical =
    const OrderCollectionBy._('Alphabetical');

OrderCollectionBy _$valueOf(String name) {
  switch (name) {
    case 'Rating':
      return _$Rating;
    case 'CollectedTime':
      return _$CollectedTime;
    case 'ReleaseDate':
      return _$ReleaseDate;
    case 'Alphabetical':
      return _$Alphabetical;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<OrderCollectionBy> _$values =
    new BuiltSet<OrderCollectionBy>(const <OrderCollectionBy>[
  _$Rating,
  _$CollectedTime,
  _$ReleaseDate,
  _$Alphabetical,
]);

Serializer<OrderCollectionBy> _$orderCollectionBySerializer =
    new _$OrderCollectionBySerializer();

class _$OrderCollectionBySerializer
    implements PrimitiveSerializer<OrderCollectionBy> {
  @override
  final Iterable<Type> types = const <Type>[OrderCollectionBy];
  @override
  final String wireName = 'OrderCollectionBy';

  @override
  Object serialize(Serializers serializers, OrderCollectionBy object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  OrderCollectionBy deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderCollectionBy.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
