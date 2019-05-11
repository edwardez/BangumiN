import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'EpisodeProgress.g.dart';

abstract class EpisodeProgress
    implements Built<EpisodeProgress, EpisodeProgressBuilder> {
  EpisodeProgress._();

  factory EpisodeProgress([updates(EpisodeProgressBuilder b)]) =
      _$EpisodeProgress;

  /// id of this episode. This id can be used to uniquely identify an episode
  /// across all bangumi subjects
  int get id;

  /// sequential number of this episode under current subject,  it typically starts
  /// from 1
  /// This number can be double(i.e. episode 12.5)
  @BuiltValueField(wireName: 'sort')
  double get sequentialNumber;

  String get name;

  @BuiltValueField(wireName: 'name_cn')
  String get nameCn;

  String get duration;

  @BuiltValueField(wireName: 'airdate')
  String get airDate;

  @BuiltValueField(wireName: 'comment')
  int get totalCommentsCount;

  /// A short introduction summary of this episode
  /// This info is only available in api
  @nullable
  @BuiltValueField(wireName: 'desc')
  String get summary;

  /// Current air status of this episode(has been aired or not)
  @BuiltValueField(wireName: 'status')
  AirStatus get airStatus;

  /// Current user episode status of this episode(has been watched or not)
  /// Note: user can mark an episode as 'watched' regardless its airStatus
  @BuiltValueField(wireName: 'user_episode_status')
  EpisodeStatus get userEpisodeStatus;

  EpisodeType get episodeType;

  String toJson() {
    return json
        .encode(serializers.serializeWith(EpisodeProgress.serializer, this));
  }

  static EpisodeProgress fromJson(String jsonString) {
    return serializers.deserializeWith(
        EpisodeProgress.serializer, json.decode(jsonString));
  }

  static Serializer<EpisodeProgress> get serializer =>
      _$episodeProgressSerializer;
}
