// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Mono.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Mono _$Character = const Mono._('Character');
const Mono _$Person = const Mono._('Person');

Mono _$valueOf(String name) {
  switch (name) {
    case 'Character':
      return _$Character;
    case 'Person':
      return _$Person;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Mono> _$values = new BuiltSet<Mono>(const <Mono>[
  _$Character,
  _$Person,
]);

Serializer<Mono> _$monoSerializer = new _$MonoSerializer();

class _$MonoSerializer implements PrimitiveSerializer<Mono> {
  @override
  final Iterable<Type> types = const <Type>[Mono];
  @override
  final String wireName = 'Mono';

  @override
  Object serialize(Serializers serializers, Mono object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Mono deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Mono.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
