import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/BaseEpisode.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'EpisodeProgress.g.dart';

abstract class EpisodeProgress
    implements BaseEpisode, Built<EpisodeProgress, EpisodeProgressBuilder> {
  EpisodeProgress._();

  factory EpisodeProgress([updates(EpisodeProgressBuilder b)]) =
      _$EpisodeProgress;

  /// sequential number of this episode under current subject,  it typically starts
  /// from 1
  /// This number can be double(i.e. episode 12.5)
  @BuiltValueField(wireName: 'sort')
  double get sequentialNumber;

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
