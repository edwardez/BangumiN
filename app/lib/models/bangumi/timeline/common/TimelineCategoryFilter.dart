import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';

part 'TimelineCategoryFilter.g.dart';

/// Category level filter for timeline, it determines feed category
/// see [TimelineSource]
class TimelineCategoryFilter extends EnumClass {
  /// This value need to keep sync with [TimelineCategoryFilter.values.length]
  /// This value decides how many sub menus timeline widget has
  static const totalTimelineTypes = 11;

  /// web: https://bgm.tv/timeline?
  static const TimelineCategoryFilter AllFeeds = _$AllFeeds;

  /// web: https://bgm.tv/timeline?type=say
  static const TimelineCategoryFilter PublicMessage = _$PublicMessage;

  /// web:https://bgm.tv/timeline?type=subject
  static const TimelineCategoryFilter Collection = _$Collection;

  /// web: https://bgm.tv/rakuen/topiclist?type=ep
  static const TimelineCategoryFilter Progress = _$Progress;

  /// web: https://bgm.tv/rakuen/topiclist?type=blog
  static const TimelineCategoryFilter Blog = _$Blog;

  /// web: https://bgm.tv/timeline?type=mono
  static const TimelineCategoryFilter Mono = _$Mono;

  /// web: https://bgm.tv/timeline?type=relation
  static const TimelineCategoryFilter FriendShip = _$FriendShip;

  /// web: https://bgm.tv/timeline?type=group
  static const TimelineCategoryFilter Group = _$ProgressUpdate;

  /// web: https://bgm.tv/timeline?type=wiki
  static const TimelineCategoryFilter Wiki = _$Wiki;

  /// web: https://bgm.tv/timeline?type=index
  static const TimelineCategoryFilter Catalog = _$Catalog;

  /// web: https://bgm.tv/timeline?type=doujin
  static const TimelineCategoryFilter Doujin = _$Doujin;

  const TimelineCategoryFilter._(String name) : super(name);

  static BuiltSet<TimelineCategoryFilter> get values => _$values;

  static TimelineCategoryFilter valueOf(String name) => _$valueOf(name);

  static Serializer<TimelineCategoryFilter> get serializer =>
      _$timelineCategoryFilterSerializer;

  @memoized
  String get bangumiQueryParameterValue {
    switch (this) {
      case TimelineCategoryFilter.AllFeeds:
        return '';
      case TimelineCategoryFilter.PublicMessage:
        return 'say';
      case TimelineCategoryFilter.Collection:
        return 'subject';
      case TimelineCategoryFilter.Progress:
        return 'progress';
      case TimelineCategoryFilter.Blog:
        return 'blog';
      case TimelineCategoryFilter.Mono:
        return 'mono';
      case TimelineCategoryFilter.FriendShip:
        return 'relation';
      case TimelineCategoryFilter.Group:
        return 'group';
      case TimelineCategoryFilter.Wiki:
        return 'wiki';
      case TimelineCategoryFilter.Catalog:
        return 'index';
      case TimelineCategoryFilter.Doujin:
        return 'doujin';
      default:

      /// we should never use default value, this error needs to be caught
      /// in dev environment
        assert(false, 'Cannot find BangumiQueryParameterValue for $this');
        return '';
    }
  }

  @memoized
  String get chineseName {
    switch (this) {
      case TimelineCategoryFilter.AllFeeds:
        return '动态';
      case TimelineCategoryFilter.PublicMessage:
        return '吐槽';
      case TimelineCategoryFilter.Collection:
        return '收藏';
      case TimelineCategoryFilter.Progress:
        return '进度';
      case TimelineCategoryFilter.Blog:
        return '日志';
      case TimelineCategoryFilter.Mono:
        return '人物';
      case TimelineCategoryFilter.FriendShip:
        return '好友';
      case TimelineCategoryFilter.Group:
        return '小组';
      case TimelineCategoryFilter.Wiki:
        return '维基';
      case TimelineCategoryFilter.Catalog:
        return '目录';
      case TimelineCategoryFilter.Doujin:
        return '天窗';
      default:

      /// we should never use default value, this error needs to be caught
      /// in dev environment
        assert(false, 'Cannot find chineseName for $this');
        return '-';
    }
  }

  /// Get current page index in timeline page
  /// Index must be consecutive and unique
  int get pageIndex {
    switch (this) {
      case TimelineCategoryFilter.AllFeeds:
        return 0;
      case TimelineCategoryFilter.PublicMessage:
        return 1;
      case TimelineCategoryFilter.Collection:
        return 2;
      case TimelineCategoryFilter.Progress:
        return 3;
      case TimelineCategoryFilter.Blog:
        return 4;
      case TimelineCategoryFilter.Mono:
        return 5;
      case TimelineCategoryFilter.FriendShip:
        return 6;
      case TimelineCategoryFilter.Group:
        return 7;
      case TimelineCategoryFilter.Wiki:
        return 8;
      case TimelineCategoryFilter.Catalog:
        return 9;
      case TimelineCategoryFilter.Doujin:
        return 10;
      default:

      /// we should never use default value, this error needs to be caught
      /// in dev environment
        assert(false, '$this doesn\'t have a valid page index');
        return 0;
    }
  }
}
