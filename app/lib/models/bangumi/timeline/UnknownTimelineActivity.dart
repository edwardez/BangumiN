import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'UnknownTimelineActivity.g.dart';

abstract class UnknownTimelineActivity
    implements
        Built<UnknownTimelineActivity, UnknownTimelineActivityBuilder>,
        TimelineFeed {
  /// no-op, this should always be null
  @nullable
  FeedMetaInfo get user;

  String get content;

  @nullable
  BangumiContent get bangumiContent;

  UnknownTimelineActivity._();

  factory UnknownTimelineActivity([updates(UnknownTimelineActivityBuilder b)]) =
      _$UnknownTimelineActivity;

  static Serializer<UnknownTimelineActivity> get serializer =>
      _$unknownTimelineActivitySerializer;
}
