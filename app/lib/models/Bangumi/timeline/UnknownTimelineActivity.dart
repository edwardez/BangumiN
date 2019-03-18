import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineFeed.dart';

part 'UnknownTimelineActivity.g.dart';

abstract class UnknownTimelineActivity
    implements
        Built<UnknownTimelineActivity, UnknownTimelineActivityBuilder>,
        TimelineFeed {

  /// no-op, this should always be null
  @nullable
  FeedMetaInfo get user;

  String get content;

  UnknownTimelineActivity._();

  factory UnknownTimelineActivity([updates(UnknownTimelineActivityBuilder b)]) =
      _$UnknownTimelineActivity;

  static Serializer<UnknownTimelineActivity> get serializer =>
      _$unknownTimelineActivitySerializer;
}
