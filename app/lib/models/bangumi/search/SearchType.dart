import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'SearchType.g.dart';

/// [EnumClass] for [SearchType]
/// Value in [wireName] is from Bangumi API response
class SearchType extends EnumClass {
  static const SearchType AnySubject = _$AnySubject;

  @BuiltValueEnumConst(wireName: '1')
  static const SearchType Book = _$Book;

  @BuiltValueEnumConst(wireName: '2')
  static const SearchType Anime = _$Anime;

  @BuiltValueEnumConst(wireName: '3')
  static const SearchType Music = _$Music;

  @BuiltValueEnumConst(wireName: '4')
  static const SearchType Game = _$Game;

  @BuiltValueEnumConst(wireName: '6')
  static const SearchType Real = _$Real;
  static const SearchType Character = _$Character;
  static const SearchType Person = _$Person;
  static const SearchType User = _$User;

  static const subjectSearchType = {
    SearchType.AnySubject,
    SearchType.Book,
    SearchType.Anime,
    SearchType.Music,
    SearchType.Game,
    SearchType.Real,
  };

  @memoized
  String get chineseName {
    switch (this) {
      case SearchType.AnySubject:
        return '全部作品';
      case SearchType.Book:
        return '书籍';
      case SearchType.Anime:
        return '动画';
      case SearchType.Music:
        return '音乐';
      case SearchType.Game:
        return '游戏';
      case SearchType.Real:
        return '三次元';
      case SearchType.Character:
        return '虚拟角色';
      case SearchType.Person:
        return '现实人物';
      case SearchType.User:
        return '站内用户';
      default:
        return '条目';
    }
  }

  @memoized
  String get wiredName {
    switch (this) {
      case SearchType.Book:
        return '1';
      case SearchType.Anime:
        return '2';
      case SearchType.Music:
        return '3';
      case SearchType.Game:
        return '4';
      case SearchType.Real:
        return '6';
      default:
        assert(true);
        return null;
    }
  }

  @memoized
  bool get isSubjectSearchType {
    return subjectSearchType.contains(this);
  }

  /// Get relevant search type by subject type int
  /// Int is defined by(and can only be) bangumi subject type
  /// This doesn't apply to person, character or user
  static SearchType subjectSearchTypeByTypeInt(int typeInt) {
    assert({1, 2, 3, 4, 6}.contains(typeInt));

    switch (typeInt) {
      case 1:
        return SearchType.Book;
      case 2:
        return SearchType.Anime;
      case 3:
        return SearchType.Music;
      case 4:
        return SearchType.Game;
      case 6:
        return SearchType.Real;
      default:
        return SearchType.AnySubject;
    }
  }

  const SearchType._(String name) : super(name);

  static BuiltSet<SearchType> get values => _$values;

  static SearchType valueOf(String name) => _$valueOf(name);

  static Serializer<SearchType> get serializer => _$searchTypeSerializer;
}
