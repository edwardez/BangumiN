import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/enums/base.dart';

part 'RakuenFilter.g.dart';

class RakuenTopicFilter extends EnumClass implements DiscussionFilter {
  /// web: https://bgm.tv/rakuen/topiclist
  static const RakuenTopicFilter Unrestricted = _$Unrestricted;

  /// web: https://bgm.tv/rakuen/topiclist?type=group
  static const RakuenTopicFilter AllGroups = _$AllGroups;

  /// web: https://bgm.tv/rakuen/topiclist?type=my_group
  static const RakuenTopicFilter JoinedGroups = _$JoinedGroups;

  /// web: https://bgm.tv/rakuen/topiclist?type=subject
  static const RakuenTopicFilter Subject = _$Subject;

  /// web: https://bgm.tv/rakuen/topiclist?type=ep
  static const RakuenTopicFilter Episode = _$Episode;

  /// web: https://bgm.tv/rakuen/topiclist?type=mono
  static const RakuenTopicFilter Mono = _$Mono;

  const RakuenTopicFilter._(String name) : super(name);

  static BuiltSet<RakuenTopicFilter> get values => _$values;

  static RakuenTopicFilter valueOf(String name) => _$valueOf(name);

  static Serializer<RakuenTopicFilter> get serializer =>
      _$rakuenTopicFilterSerializer;

  @memoized
  String get toBangumiQueryParameterValue {
    switch (this) {
      case RakuenTopicFilter.AllGroups:
        return 'group';
      case RakuenTopicFilter.JoinedGroups:
        return 'my_group';
      case RakuenTopicFilter.Subject:
        return 'subject';
      case RakuenTopicFilter.Episode:
        return 'ep';
      case RakuenTopicFilter.Mono:
        return 'mono';
      default:

        /// we should never use default value, this error needs to be caught
        /// in dev environment
        assert(false, 'Cannot find BangumiQueryParameterValue for $this');
        return '';
    }
  }

  @override
  @memoized
  String get chineseName {
    switch (this) {
      case RakuenTopicFilter.Unrestricted:
        return '全站讨论';
      case RakuenTopicFilter.AllGroups:
        return '全部小组';
      case RakuenTopicFilter.JoinedGroups:
        return '加入的小组';
      case RakuenTopicFilter.Subject:
        return '作品';
      case RakuenTopicFilter.Episode:
        return '章节';
      case RakuenTopicFilter.Mono:
        return '人物';
      default:

        /// we should never use default value, this error needs to be caught
        /// in dev environment
        assert(false, 'Cannot find chineseName for $this');
        return '条目';
    }
  }
}
