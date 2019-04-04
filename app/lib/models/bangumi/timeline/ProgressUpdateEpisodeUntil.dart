import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'ProgressUpdateEpisodeUntil.g.dart';

abstract class ProgressUpdateEpisodeUntil
    implements
        Built<ProgressUpdateEpisodeUntil, ProgressUpdateEpisodeUntilBuilder>,
        TimelineFeed {
  FeedMetaInfo get user;

  String get subjectName;

  String get subjectId;

  ProgressUpdateEpisodeUntil._();

  factory ProgressUpdateEpisodeUntil(
          [updates(ProgressUpdateEpisodeUntilBuilder b)]) =
      _$ProgressUpdateEpisodeUntil;

  static Serializer<ProgressUpdateEpisodeUntil> get serializer =>
      _$progressUpdateEpisodeUntilSerializer;
}
