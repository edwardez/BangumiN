import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';

part 'TimelineFeed.g.dart';

/// a base TimelineFeed interface
@BuiltValue(instantiable: false)
abstract class TimelineFeed {
  FeedMetaInfo get user;

  /// To keep a complete timeline, muted user feeds will still be stored
  /// but not shown to user, this is controlled by `isFromMutedUser` field
  @nullable
  bool get isFromMutedUser;

  TimelineFeed rebuild(void updates(TimelineFeedBuilder b));

  TimelineFeedBuilder toBuilder();
}
