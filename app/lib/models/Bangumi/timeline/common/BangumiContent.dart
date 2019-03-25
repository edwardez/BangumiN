import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'BangumiContent.g.dart';

class BangumiContent extends EnumClass {
  static const BangumiContent PublicMessage = _$PublicMessage;
  static const BangumiContent Episode = _$Episode;
  static const BangumiContent Subject = _$Subject;
  static const BangumiContent Blog = _$Blog;
  static const BangumiContent Character = _$Character;
  static const BangumiContent Person = _$Person;
  static const BangumiContent Friend = _$Friend;
  static const BangumiContent Group = _$Group;
  static const BangumiContent Wiki = _$Wiki;
  static const BangumiContent Catalog = _$Catalog;
  static const BangumiContent Doujin = _$Doujin;
  static const BangumiContent CharacterOrPerson = _$CharacterOrPerson;

  static const Map<BangumiContent, String> enumToWebPageRouteName = {
    BangumiContent.Subject: 'subject',
    BangumiContent.Episode: 'ep',
    BangumiContent.Friend: 'user',
    BangumiContent.Group: 'group',
    BangumiContent.Blog: 'blog',
    BangumiContent.Catalog: 'index',
    BangumiContent.Doujin: 'doujin',
    BangumiContent.Character: 'character',
    BangumiContent.Person: 'person',

    /// all timeline wiki activity means user creates a new subject
    BangumiContent.Wiki: 'subject',
  };

  /// a plain text item
  static const BangumiContent PlainText = _$PlainText;
  static const BangumiContent Unknown = _$Unknown;

  const BangumiContent._(String name) : super(name);

  static BuiltSet<BangumiContent> get values => _$values;

  static BangumiContent valueOf(String name) => _$valueOf(name);

  static Serializer<BangumiContent> get serializer =>
      _$bangumiContentSerializer;
}
