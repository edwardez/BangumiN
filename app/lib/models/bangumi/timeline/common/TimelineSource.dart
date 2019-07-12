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
  static const TimelineSource OnlyFriends = _$OnlyFriends;

  /// Feeds for a single user
  /// web: https://bgm.tv/user/example/timeline?
  static const TimelineSource UserProfile = _$UserProfile;

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
      case TimelineSource.OnlyFriends:
        return '好友';
      default:
        return '-';

        /// Default value shouldn\'t be used, this error needs to be caught
        /// in dev environment
        assert(false, 'Cannot find chineseName for $this');
        return '-';
    }
  }
}
