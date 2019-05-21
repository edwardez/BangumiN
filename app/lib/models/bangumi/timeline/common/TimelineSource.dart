import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'TimelineSource.g.dart';

/// Source for timeline
/// It determines whether feeds are from friends, or the whole web site
/// see [TimelineCategoryFilter]
class TimelineSource extends EnumClass {
  /// Feeds for all Bangumi users
  /// web: https://bgm.tv/timeline? if user is not logged in
  static const TimelineSource AllUsers = _$AllFeeds;

  /// Feeds for all users that current user has made friend of
  /// web: https://bgm.tv/timeline?type=say
  static const TimelineSource FriendsOnly = _$FriendsOnly;

  const TimelineSource._(String name) : super(name);

  static BuiltSet<TimelineSource> get values => _$values;

  static TimelineSource valueOf(String name) => _$valueOf(name);

  static Serializer<TimelineSource> get serializer =>
      _$timelineSourceSerializer;

  @memoized
  String get chineseName {
    switch (this) {
      case TimelineSource.AllUsers:
        return '全站';
      case TimelineSource.FriendsOnly:
        return '好友';
      default:

        /// we should never use default value, this error needs to be caught
        /// in dev environment
        assert(false, 'Cannot find chineseName for $this');
        return '-';
    }
  }
}
