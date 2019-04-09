// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchType.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SearchType _$AnySubject = const SearchType._('AnySubject');
const SearchType _$Book = const SearchType._('Book');
const SearchType _$Anime = const SearchType._('Anime');
const SearchType _$Music = const SearchType._('Music');
const SearchType _$Game = const SearchType._('Game');
const SearchType _$Real = const SearchType._('Real');
const SearchType _$Character = const SearchType._('Character');
const SearchType _$Person = const SearchType._('Person');
const SearchType _$User = const SearchType._('User');

SearchType _$valueOf(String name) {
  switch (name) {
    case 'AnySubject':
      return _$AnySubject;
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
    case 'Character':
      return _$Character;
    case 'Person':
      return _$Person;
    case 'User':
      return _$User;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SearchType> _$values =
    new BuiltSet<SearchType>(const <SearchType>[
  _$AnySubject,
  _$Book,
  _$Anime,
  _$Music,
  _$Game,
  _$Real,
  _$Character,
  _$Person,
  _$User,
]);

Serializer<SearchType> _$searchTypeSerializer = new _$SearchTypeSerializer();

class _$SearchTypeSerializer implements PrimitiveSerializer<SearchType> {
  static const Map<String, String> _toWire = const <String, String>{
    'Book': '1',
    'Anime': '2',
    'Music': '3',
    'Game': '4',
    'Real': '6',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    '1': 'Book',
    '2': 'Anime',
    '3': 'Music',
    '4': 'Game',
    '6': 'Real',
  };

  @override
  final Iterable<Type> types = const <Type>[SearchType];
  @override
  final String wireName = 'SearchType';

  @override
  Object serialize(Serializers serializers, SearchType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SearchType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SearchType.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
