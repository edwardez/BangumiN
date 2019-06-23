import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/common/BaseEpisode.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';

/// Checks if episode will be affected by [EpisodeUpdateType.CollectUntil]
bool isEpisodeAffectedByCollectUntilOperation(BaseEpisode episode) {
  return episode.episodeType == EpisodeType.Regular &&
      episode.userEpisodeStatus != EpisodeStatus.Dropped;
}

/// Watch until only affects previous episodes with smaller sequential number that
/// are regular episodes and status is not [EpisodeStatus.Dropped].
/// [EpisodeProgress] has an additional [sequentialNumber] which can be used to
/// check which episodes are behind new EpisodeNumber.
bool isEpisodeProgressAffectedByCollectUntilOperation(
    EpisodeProgress episode, int newEpisodeNumber) {
  return isEpisodeAffectedByCollectUntilOperation(episode) &&
      episode.sequentialNumber <= newEpisodeNumber;
}
