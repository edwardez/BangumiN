// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThreadType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ThreadType _$Blog = const ThreadType._('Blog');
const ThreadType _$Group = const ThreadType._('Group');
const ThreadType _$SubjectTopic = const ThreadType._('SubjectTopic');
const ThreadType _$Episode = const ThreadType._('Episode');

ThreadType _$valueOf(String name) {
  switch (name) {
    case 'Blog':
      return _$Blog;
    case 'Group':
      return _$Group;
    case 'SubjectTopic':
      return _$SubjectTopic;
    case 'Episode':
      return _$Episode;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ThreadType> _$values =
    new BuiltSet<ThreadType>(const <ThreadType>[
  _$Blog,
  _$Group,
  _$SubjectTopic,
  _$Episode,
]);

Serializer<ThreadType> _$threadTypeSerializer = new _$ThreadTypeSerializer();

class _$ThreadTypeSerializer implements PrimitiveSerializer<ThreadType> {
  @override
  final Iterable<Type> types = const <Type>[ThreadType];
  @override
  final String wireName = 'ThreadType';

  @override
  Object serialize(Serializers serializers, ThreadType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ThreadType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ThreadType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
