// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DiscussionType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DiscussionType _$Rakuen = const DiscussionType._('Rakuen');
const DiscussionType _$Group = const DiscussionType._('Group');

DiscussionType _$valueOf(String name) {
  switch (name) {
    case 'Rakuen':
      return _$Rakuen;
    case 'Group':
      return _$Group;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DiscussionType> _$values =
    new BuiltSet<DiscussionType>(const <DiscussionType>[
  _$Rakuen,
  _$Group,
]);

Serializer<DiscussionType> _$discussionTypeSerializer =
    new _$DiscussionTypeSerializer();

class _$DiscussionTypeSerializer
    implements PrimitiveSerializer<DiscussionType> {
  @override
  final Iterable<Type> types = const <Type>[DiscussionType];
  @override
  final String wireName = 'DiscussionType';

  @override
  Object serialize(Serializers serializers, DiscussionType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  DiscussionType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DiscussionType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
