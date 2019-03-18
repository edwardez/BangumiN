import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'TimelineState.g.dart';

abstract class TimelineState
    implements Built<TimelineState, TimelineStateBuilder> {
  @nullable
  FeedChunks get feedChunks;

  TimelineState._();

  factory TimelineState([updates(TimelineStateBuilder b)]) =>
      _$TimelineState((b) => b
        ..feedChunks.replace(FeedChunks())
        ..update(updates));

  String toJson() {
    return json
        .encode(serializers.serializeWith(TimelineState.serializer, this));
  }

  static TimelineState fromJson(String jsonString) {
    return serializers.deserializeWith(
        TimelineState.serializer, json.decode(jsonString));
  }

  static Serializer<TimelineState> get serializer => _$timelineStateSerializer;
}
