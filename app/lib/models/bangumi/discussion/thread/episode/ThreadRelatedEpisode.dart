import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'ThreadRelatedEpisode.g.dart';

/// Related episodes in a subject episode thread.
/// Note: this is not a exhaustive list of all related episodes of a subject,
/// as Bangumi doesn't return all related episodes.
abstract class ThreadRelatedEpisode
    implements Built<ThreadRelatedEpisode, ThreadRelatedEpisodeBuilder> {
  int get id;

  AirStatus get airStatus;

  String get name;

  /// Whether the episode is the discussed episode of current episode thread.
  bool get currentEpisode;

  ThreadRelatedEpisode._();

  factory ThreadRelatedEpisode(
          [void Function(ThreadRelatedEpisodeBuilder) updates]) =
      _$ThreadRelatedEpisode;

  String toJson() {
    return json.encode(
        serializers.serializeWith(ThreadRelatedEpisode.serializer, this));
  }

  static ThreadRelatedEpisode fromJson(String jsonString) {
    return serializers.deserializeWith(
        ThreadRelatedEpisode.serializer, json.decode(jsonString));
  }

  static Serializer<ThreadRelatedEpisode> get serializer =>
      _$threadRelatedEpisodeSerializer;
}
