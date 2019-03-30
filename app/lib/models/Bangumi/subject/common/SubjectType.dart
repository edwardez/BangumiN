import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'SubjectType.g.dart';

class SubjectType extends EnumClass {
  /// we use a 'trick' here, bangumi will return all results if type is not in their list, so we use -1 to indicate all type
  static const SubjectType All = _$All;
  static const SubjectType Book = _$Book;
  static const SubjectType Anime = _$Anime;
  static const SubjectType Music = _$Music;
  static const SubjectType Game = _$Game;
  static const SubjectType Real = _$Real;

  static getTypeByChineseName(String chineseName) {
    switch (chineseName) {
      case '书籍':
        return SubjectType.Book;
      case '动画':
        return SubjectType.Anime;
      case '音乐':
        return SubjectType.Music;
      case '游戏':
        return SubjectType.Game;
      case '三次元':
        return SubjectType.Real;
      default:
        return SubjectType.All;
    }
  }

  /// Get quantified chinese name by subject type
  /// '一本书', '一张唱片' ...etc
  /// TODO(edward): I feel like there is a better way to get it's enum type...
  @memoized
  String get quantifiedChineseNameByType {
    switch (SubjectType.valueOf(this.name)) {
      case SubjectType.Book:
        return '本书';
      case SubjectType.Anime:
        return '部动画';
      case SubjectType.Music:
        return '张唱片';
      case SubjectType.Game:
        return '个游戏';
      case SubjectType.Real:
        return '部剧';
      case SubjectType.All:
      default:
        return '个作品';
    }
  }

  const SubjectType._(String name) : super(name);

  static BuiltSet<SubjectType> get values => _$values;

  static SubjectType valueOf(String name) => _$valueOf(name);

  static Serializer<SubjectType> get serializer => _$subjectTypeSerializer;
}
