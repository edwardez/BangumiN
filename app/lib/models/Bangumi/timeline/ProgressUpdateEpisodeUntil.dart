import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'ProgressUpdateEpisodeUntil.g.dart';

abstract class ProgressUpdateEpisodeUntil
    implements
        Built<ProgressUpdateEpisodeUntil, ProgressUpdateEpisodeUntilBuilder> {
  TimelineUserInfo get user;

  String get subjectName;

  int get subjectId;

  ProgressUpdateEpisodeUntil._();

  factory ProgressUpdateEpisodeUntil(
          [updates(ProgressUpdateEpisodeUntilBuilder b)]) =
      _$ProgressUpdateEpisodeUntil;
}
