// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiContent.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BangumiContent _$PublicMessage = const BangumiContent._('PublicMessage');
const BangumiContent _$Episode = const BangumiContent._('Episode');
const BangumiContent _$Subject = const BangumiContent._('Subject');
const BangumiContent _$SubjectTopic = const BangumiContent._('SubjectTopic');
const BangumiContent _$Blog = const BangumiContent._('Blog');
const BangumiContent _$Character = const BangumiContent._('Character');
const BangumiContent _$Person = const BangumiContent._('Person');
const BangumiContent _$User = const BangumiContent._('User');
const BangumiContent _$Group = const BangumiContent._('Group');
const BangumiContent _$GroupTopic = const BangumiContent._('GroupTopic');
const BangumiContent _$Wiki = const BangumiContent._('Wiki');
const BangumiContent _$Catalog = const BangumiContent._('Catalog');
const BangumiContent _$Doujin = const BangumiContent._('Doujin');
const BangumiContent _$CharacterOrPerson =
    const BangumiContent._('CharacterOrPerson');
const BangumiContent _$PlainText = const BangumiContent._('PlainText');
const BangumiContent _$Unknown = const BangumiContent._('Unknown');

BangumiContent _$valueOf(String name) {
  switch (name) {
    case 'PublicMessage':
      return _$PublicMessage;
    case 'Episode':
      return _$Episode;
    case 'Subject':
      return _$Subject;
    case 'SubjectTopic':
      return _$SubjectTopic;
    case 'Blog':
      return _$Blog;
    case 'Character':
      return _$Character;
    case 'Person':
      return _$Person;
    case 'User':
      return _$User;
    case 'Group':
      return _$Group;
    case 'GroupTopic':
      return _$GroupTopic;
    case 'Wiki':
      return _$Wiki;
    case 'Catalog':
      return _$Catalog;
    case 'Doujin':
      return _$Doujin;
    case 'CharacterOrPerson':
      return _$CharacterOrPerson;
    case 'PlainText':
      return _$PlainText;
    case 'Unknown':
      return _$Unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<BangumiContent> _$values =
    new BuiltSet<BangumiContent>(const <BangumiContent>[
  _$PublicMessage,
  _$Episode,
  _$Subject,
  _$SubjectTopic,
  _$Blog,
  _$Character,
  _$Person,
  _$User,
  _$Group,
  _$GroupTopic,
  _$Wiki,
  _$Catalog,
  _$Doujin,
  _$CharacterOrPerson,
  _$PlainText,
  _$Unknown,
]);

Serializer<BangumiContent> _$bangumiContentSerializer =
    new _$BangumiContentSerializer();

class _$BangumiContentSerializer
    implements PrimitiveSerializer<BangumiContent> {
  @override
  final Iterable<Type> types = const <Type>[BangumiContent];
  @override
  final String wireName = 'BangumiContent';

  @override
  Object serialize(Serializers serializers, BangumiContent object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  BangumiContent deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BangumiContent.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
