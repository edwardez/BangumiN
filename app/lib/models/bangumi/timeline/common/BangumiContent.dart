import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';

part 'BangumiContent.g.dart';

class BangumiContent extends EnumClass {
  static const BangumiContent PublicMessage = _$PublicMessage;
  static const BangumiContent Episode = _$Episode;
  static const BangumiContent Subject = _$Subject;

  /// i.e. https://bgm.tv/subject/topic/1
  /// Note: topic id is independent of subject id
  /// [SubjectTopic] currently won't show up on user timeline
  static const BangumiContent SubjectTopic = _$SubjectTopic;
  static const BangumiContent Blog = _$Blog;
  static const BangumiContent Character = _$Character;
  static const BangumiContent Person = _$Person;
  static const BangumiContent User = _$User;
  static const BangumiContent Group = _$Group;

  /// i.e. https://bgm.tv/group/topic/1
  /// Note: topic id is independent of group id
  /// [GroupTopic] currently won't show up on user timeline
  static const BangumiContent GroupTopic = _$GroupTopic;
  static const BangumiContent Wiki = _$Wiki;
  static const BangumiContent Catalog = _$Catalog;
  static const BangumiContent Doujin = _$Doujin;
  static const BangumiContent CharacterOrPerson = _$CharacterOrPerson;

  static const Map<BangumiContent, String> enumToWebPageRouteName = {
    BangumiContent.Subject: 'subject',
    BangumiContent.SubjectTopic: 'subject/topic',
    BangumiContent.Episode: 'ep',
    BangumiContent.User: 'user',
    BangumiContent.Group: 'group',
    BangumiContent.GroupTopic: 'group/topic',
    BangumiContent.Blog: 'blog',
    BangumiContent.Catalog: 'index',
    BangumiContent.Doujin: 'doujin',
    BangumiContent.Character: 'character',
    BangumiContent.Person: 'person',

    /// all timeline wiki activity means user creates a new subject
    BangumiContent.Wiki: 'subject',
  };

  static const Set<BangumiContent> monoTypes = {
  BangumiContent.CharacterOrPerson,
  BangumiContent.Person,
  BangumiContent.Character
  };

  @memoized
  bool get isMono {
    return monoTypes.contains(this);
  }

  @memoized
  String get chineseName {
    switch (this) {
      case BangumiContent.Subject:
        return '作品';
      case BangumiContent.SubjectTopic:
        return '作品讨论';
      case BangumiContent.Episode:
        return '章节讨论';
      case BangumiContent.User:
        return '用户';
      case BangumiContent.Group:
        return '小组';
      case BangumiContent.GroupTopic:
        return '小组话题';
      case BangumiContent.Blog:
        return '日志';
      case BangumiContent.Catalog:
        return '目录';
      case BangumiContent.Doujin:
        return '天窗';
      case BangumiContent.Character:
        return '角色';
      case BangumiContent.Person:
        return '现实人物';
      default:

      /// we should never use default directly
        assert(false, 'Cannot find chineseName for $this');
        return '条目';
    }
  }

  ImageType get imageType {
    switch (this) {
      case BangumiContent.Person:
      case BangumiContent.Character:
      case BangumiContent.Subject:
      case BangumiContent.SubjectTopic:
      case BangumiContent.Episode:
      case BangumiContent.Doujin:
        return ImageType.SubjectCover;
      case BangumiContent.User:
      case BangumiContent.GroupTopic:
        return ImageType.UserAvatar;
      case BangumiContent.Group:
        return ImageType.GroupIcon;
      default:
        assert(false, '$this doesn\'t have a valid ImageType');
        return ImageType.SubjectCover;
    }
  }

  /// a plain text item
  static const BangumiContent PlainText = _$PlainText;
  static const BangumiContent Unknown = _$Unknown;

  const BangumiContent._(String name) : super(name);

  static BuiltSet<BangumiContent> get values => _$values;

  static BangumiContent valueOf(String name) => _$valueOf(name);

  static Serializer<BangumiContent> get serializer =>
      _$bangumiContentSerializer;
}
