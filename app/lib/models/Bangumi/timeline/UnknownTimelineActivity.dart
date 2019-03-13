import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'UnknownTimelineActivity.g.dart';

abstract class UnknownTimelineActivity
    implements Built<UnknownTimelineActivity, UnknownTimelineActivityBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  TimelineUserInfo get user;

  String get content;

  UnknownTimelineActivity._();

  factory UnknownTimelineActivity([updates(UnknownTimelineActivityBuilder b)]) =
      _$UnknownTimelineActivity;
}
