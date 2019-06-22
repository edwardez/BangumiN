import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'TimelineState.g.dart';

abstract class TimelineState
    implements Built<TimelineState, TimelineStateBuilder> {
  BuiltMap<GetTimelineRequest, FeedChunks> get timeline;

  TimelineState._();

  factory TimelineState([updates(TimelineStateBuilder b)]) =>
      _$TimelineState((b) => b
        ..timeline.replace(BuiltMap<GetTimelineRequest, FeedChunks>())
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
