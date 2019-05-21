import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'EpisodeUpdateType.g.dart';

class EpisodeUpdateType extends EnumClass {
  /// List the episode on user's wish list
  static const EpisodeUpdateType Wish = _$Wish;

  /// Set the episode to 'watched'
  static const EpisodeUpdateType Collect = _$Collect;

  /// Set all episode before and including this one to 'watched'
  /// Note: CollectUntil is updated through an api different from others
  static const EpisodeUpdateType CollectUntil = _$CollectUntil;

  /// Set the episode to 'dropped'
  static const EpisodeUpdateType Dropped = _$Dropped;

  /// Remove episode status if there is any
  static const EpisodeUpdateType Remove = _$Unknown;

  /// wiredName here must match bangumi api
  @memoized
  String get wiredName {
    switch (this) {
      case EpisodeUpdateType.Remove:
        return 'remove';
      case EpisodeUpdateType.Wish:
        return 'queue';
      case EpisodeUpdateType.Collect:
        return 'watched';
      case EpisodeUpdateType.Dropped:
        return 'drop';
      default:

        /// Note: CollectUntil is updated through an different api different which
        /// doesn't require a wired name
        assert(false, '$this doesn\'t have a valid wired name');
        return 'watched';
    }
  }

  @memoized
  String get chineseNameForSingleUpdate {
    switch (this) {
      case EpisodeUpdateType.Remove:
        return '撤销状态';
      case EpisodeUpdateType.Wish:
        return '想看';
      case EpisodeUpdateType.Collect:
        return '看过';
      case EpisodeUpdateType.Dropped:
        return '抛弃';
      default:

        /// Note: CollectUntil is a batch update operation(instead of a single update)
        assert(false, '$this doesn\'t have a valid wired name');
        return '神秘状态';
    }
  }

  /// The [EpisodeStatus] after performing this update
  @memoized
  EpisodeStatus get destinationEpisodeStatus {
    switch (this) {
      case EpisodeUpdateType.Remove:
        return EpisodeStatus.Untouched;
      case EpisodeUpdateType.Wish:
        return EpisodeStatus.Wish;
      case EpisodeUpdateType.Collect:
        return EpisodeStatus.Collect;
      case EpisodeUpdateType.Dropped:
        return EpisodeStatus.Dropped;
      default:

        /// Note: CollectUntil is a batch update operation(instead of a single update)
        assert(false, '$this doesn\'t have a valid destinationEpisodeStatus');
        return EpisodeStatus.Untouched;
    }
  }

  static int watchedEpisodeCountChange(
      EpisodeStatus currentStatus, EpisodeUpdateType updateType) {
    if (currentStatus == updateType.destinationEpisodeStatus) {
      return 0;
    }

    switch (updateType) {
      case EpisodeUpdateType.Remove:
      case EpisodeUpdateType.Wish:
        if (currentStatus == EpisodeStatus.Collect ||
            currentStatus == EpisodeStatus.Dropped) {
          return -1;
        }
        return 0;
      case EpisodeUpdateType.Collect:
      case EpisodeUpdateType.Dropped:
        if (currentStatus == EpisodeStatus.Collect ||
            currentStatus == EpisodeStatus.Dropped) {
          return 0;
        }
        return 1;
      default:
        assert(false, '$updateType is not valid for watchedEpisodeCountChange');
        return 0;
    }
  }

  const EpisodeUpdateType._(String name) : super(name);

  static BuiltSet<EpisodeUpdateType> get values => _$values;

  static EpisodeUpdateType valueOf(String name) => _$valueOf(name);

  static Serializer<EpisodeUpdateType> get serializer =>
      _$episodeUpdateTypeSerializer;

  static EpisodeUpdateType fromWiredName(String wiredName) {
    return serializers.deserializeWith(EpisodeUpdateType.serializer, wiredName);
  }
}
