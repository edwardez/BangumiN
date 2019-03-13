import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'ProgressUpdateEpisodeSingle.g.dart';

abstract class ProgressUpdateEpisodeSingle
    implements
        Built<ProgressUpdateEpisodeSingle, ProgressUpdateEpisodeSingleBuilder> {
  TimelineUserInfo get user;

  String get episodeName;

  int get episodeId;

  String get subjectName;

  int get subjectId;

  ProgressUpdateEpisodeSingle._();

  factory ProgressUpdateEpisodeSingle(
          [updates(ProgressUpdateEpisodeSingleBuilder b)]) =
      _$ProgressUpdateEpisodeSingle;
}
