import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/BaseEpisode.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SimpleHtmlEpisode.g.dart';

/// An episode entity as seen on html(like https://bgm.tv/subject/1836/ep).
/// [SimpleHtmlEpisode] provides rough info of an episode. Different from [EpisodeProgress],
/// which obtains in-progress episode info from API and is more fine-grained.
/// However, [SimpleHtmlEpisode] is still needed because currently API doesn't
/// return all episodes of an subject.
abstract class SimpleHtmlEpisode
    implements BaseEpisode, Built<SimpleHtmlEpisode, SimpleHtmlEpisodeBuilder> {
  /// Episode info in a string. It's typically something like
  /// "时长:122min / 首播:2008-08-02 / 讨论:+0"
  String get episodeInfo;

  SimpleHtmlEpisode._();

  factory SimpleHtmlEpisode([void Function(SimpleHtmlEpisodeBuilder) updates]) =
      _$SimpleHtmlEpisode;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SimpleHtmlEpisode.serializer, this));
  }

  static SimpleHtmlEpisode fromJson(String jsonString) {
    return serializers.deserializeWith(
        SimpleHtmlEpisode.serializer, json.decode(jsonString));
  }

  static Serializer<SimpleHtmlEpisode> get serializer =>
      _$simpleHtmlEpisodeSerializer;
}
