// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Relationship.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Relationship _$None = const Relationship._('None');
const Relationship _$Following = const Relationship._('Following');
const Relationship _$FollowedBy = const Relationship._('FollowedBy');

Relationship _$valueOf(String name) {
  switch (name) {
    case 'None':
      return _$None;
    case 'Following':
      return _$Following;
    case 'FollowedBy':
      return _$FollowedBy;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Relationship> _$values =
    new BuiltSet<Relationship>(const <Relationship>[
  _$None,
  _$Following,
  _$FollowedBy,
]);

Serializer<Relationship> _$relationshipSerializer =
    new _$RelationshipSerializer();

class _$RelationshipSerializer implements PrimitiveSerializer<Relationship> {
  @override
  final Iterable<Type> types = const <Type>[Relationship];
  @override
  final String wireName = 'Relationship';

  @override
  Object serialize(Serializers serializers, Relationship object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Relationship deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Relationship.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
