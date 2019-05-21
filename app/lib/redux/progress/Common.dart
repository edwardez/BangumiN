import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';

/// Watch until only affects previous episodes with smaller sequential number that
/// are regular episodes and status is not `EpisodeStatus.Dropped`
bool isAffectedByCollectUntilOperation(
    EpisodeProgress episode, int newEpisodeNumber) {
  return episode.episodeType == EpisodeType.RegularEpisode &&
      episode.userEpisodeStatus != EpisodeStatus.Dropped &&
      episode.sequentialNumber <= newEpisodeNumber;
}
