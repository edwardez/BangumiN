import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'SubjectType.g.dart';

class SubjectType extends EnumClass {

  static const SubjectType Unknown = _$All;
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
        return SubjectType.Unknown;
    }
  }

  static SubjectType getTypeByWiredName(String wiredName) {
    switch (wiredName) {
      case 'book':
        return SubjectType.Book;
      case 'anime':
        return SubjectType.Anime;
      case 'music':
        return SubjectType.Music;
      case 'game':
        return SubjectType.Game;
      case 'real':
        return SubjectType.Real;
      default:
        assert(false, '$wiredName is not valid');
        return SubjectType.Unknown;
    }
  }

  @memoized
  String get chineseName {
    switch (this) {
      case SubjectType.Book:
        return '书籍';
      case SubjectType.Anime:
        return '动画';
      case SubjectType.Music:
        return '唱片';
      case SubjectType.Game:
        return '游戏';
      case SubjectType.Real:
        return '三次元';
      case SubjectType.Unknown:
      default:
        return '作品';
    }
  }

  /// Get quantified chinese name by subject type
  /// '一本书', '一张唱片' ...etc
  @memoized
  String get quantifiedChineseNameByType {
    switch (this) {
      case SubjectType.Book:
        return '本书';
      case SubjectType.Anime:
        return '部动画';
      case SubjectType.Music:
        return '张唱片';
      case SubjectType.Game:
        return '个游戏';
      case SubjectType.Real:
      case SubjectType.Unknown:
      default:
        return '部作品';
    }
  }

  /// Get quantified chinese name by subject type
  /// '一本书', '一张唱片' ...etc
  @memoized
  String get activityVerbChineseNameByType {
    switch (this) {
      case SubjectType.Book:
        return '读';
      case SubjectType.Anime:
        return '看';
      case SubjectType.Music:
        return '听';
      case SubjectType.Game:
        return '玩';
      case SubjectType.Real:
        return '看';
      case SubjectType.Unknown:
      default:
        return '看';
    }
  }

  /// [SubjectType.Unknown] is a Munin internal value that's not valid on bangumi
  @memoized
  bool get isValidOnBangumi => this != SubjectType.Unknown;


  const SubjectType._(String name) : super(name);

  static BuiltSet<SubjectType> get values => _$values;

  static SubjectType valueOf(String name) => _$valueOf(name);

  static Serializer<SubjectType> get serializer => _$subjectTypeSerializer;
}
