// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubjectType _$All = const SubjectType._('All');
const SubjectType _$Book = const SubjectType._('Book');
const SubjectType _$Anime = const SubjectType._('Anime');
const SubjectType _$Music = const SubjectType._('Music');
const SubjectType _$Game = const SubjectType._('Game');
const SubjectType _$Real = const SubjectType._('Real');

SubjectType _$valueOf(String name) {
  switch (name) {
    case 'All':
      return _$All;
    case 'Book':
      return _$Book;
    case 'Anime':
      return _$Anime;
    case 'Music':
      return _$Music;
    case 'Game':
      return _$Game;
    case 'Real':
      return _$Real;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SubjectType> _$values =
    new BuiltSet<SubjectType>(const <SubjectType>[
  _$All,
  _$Book,
  _$Anime,
  _$Music,
  _$Game,
  _$Real,
]);

Serializer<SubjectType> _$subjectTypeSerializer = new _$SubjectTypeSerializer();

class _$SubjectTypeSerializer implements PrimitiveSerializer<SubjectType> {
  @override
  final Iterable<Type> types = const <Type>[SubjectType];
  @override
  final String wireName = 'SubjectType';

  @override
  Object serialize(Serializers serializers, SubjectType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SubjectType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SubjectType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
