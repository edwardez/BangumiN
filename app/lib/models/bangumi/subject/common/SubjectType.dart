import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectType.g.dart';

class SubjectType extends EnumClass {
  static const SubjectType Unknown = _$All;

  @BuiltValueEnumConst(wireName: '1')
  static const SubjectType Book = _$Book;

  @BuiltValueEnumConst(wireName: '2')
  static const SubjectType Anime = _$Anime;

  @BuiltValueEnumConst(wireName: '3')
  static const SubjectType Music = _$Music;

  @BuiltValueEnumConst(wireName: '4')
  static const SubjectType Game = _$Game;

  @BuiltValueEnumConst(wireName: '6')
  static const SubjectType Real = _$Real;

  static const validWatchableTypes = const {
    SubjectType.Anime,
    SubjectType.Real,
    SubjectType.Book
  };

  static guessTypeByChineseName(String chineseName) {
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

  static SubjectType getTypeByHttpWiredName(String wiredName) {
    final lowerCaseName = wiredName.toLowerCase();

    switch (lowerCaseName) {
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

  @memoized
  String get wiredName {
    switch (this) {
      case SubjectType.Book:
        return '1';
      case SubjectType.Anime:
        return '2';
      case SubjectType.Music:
        return '3';
      case SubjectType.Game:
        return '4';
      case SubjectType.Real:
        return '6';
      case SubjectType.Unknown:
      default:
        assert(false, '$this doesn\'t have a valid wired name');
        return '2';
    }
  }

  const SubjectType._(String name) : super(name);

  static BuiltSet<SubjectType> get values => _$values;

  static SubjectType valueOf(String name) => _$valueOf(name);

  static Serializer<SubjectType> get serializer => _$subjectTypeSerializer;

  static SubjectType fromWiredName(String wiredName) {
    return serializers.deserializeWith(SubjectType.serializer, wiredName);
  }
}
