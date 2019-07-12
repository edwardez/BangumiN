import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'ProgressUpdateEpisodeSingle.g.dart';

abstract class ProgressUpdateEpisodeSingle
    implements
        Built<ProgressUpdateEpisodeSingle, ProgressUpdateEpisodeSingleBuilder>,
        TimelineFeed {
  FeedMetaInfo get user;

  String get episodeName;

  String get episodeId;

  String get subjectName;

  String get subjectId;

  ProgressUpdateEpisodeSingle._();

  factory ProgressUpdateEpisodeSingle(
          [updates(ProgressUpdateEpisodeSingleBuilder b)]) =
      _$ProgressUpdateEpisodeSingle;

  static Serializer<ProgressUpdateEpisodeSingle> get serializer =>
      _$progressUpdateEpisodeSingleSerializer;
}
