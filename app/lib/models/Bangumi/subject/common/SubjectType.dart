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

  static getSubjectTypeByChineseName(String chineseName) {
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

  const SubjectType._(String name) : super(name);

  static BuiltSet<SubjectType> get values => _$values;

  static SubjectType valueOf(String name) => _$valueOf(name);

  static Serializer<SubjectType> get serializer => _$subjectTypeSerializer;
}
