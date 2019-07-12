import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';

part 'BaseEpisode.g.dart';

@BuiltValue(instantiable: false)
abstract class BaseEpisode {
  /// id of this episode. This id can be used to uniquely identify an episode
  /// across all bangumi subjects
  int get id;

  String get name;

  @BuiltValueField(wireName: 'name_cn')
  String get chineseName;

  /// Current air status of this episode(has been aired or not)
  @BuiltValueField(wireName: 'status')
  AirStatus get airStatus;

  /// Current user episode status of this episode(has been watched or not)
  /// Note: user can mark an episode as 'watched' regardless its airStatus
  @BuiltValueField(wireName: 'user_episode_status')
  EpisodeStatus get userEpisodeStatus;

  EpisodeType get episodeType;

  BaseEpisode rebuild(void updates(BaseEpisodeBuilder b));

  BaseEpisodeBuilder toBuilder();
}
