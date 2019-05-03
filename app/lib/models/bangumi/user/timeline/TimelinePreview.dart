import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'TimelinePreview.g.dart';

/// a Timeline that's listed as related Timeline('关联条目') on Timeline main page
abstract class TimelinePreview
    implements Built<TimelinePreview, TimelinePreviewBuilder> {
  /// Content of this timeline in plain text
  String get content;

  /// Time when user published this timeline
  int get userUpdatedAt;

  TimelinePreview._();

  factory TimelinePreview([updates(TimelinePreviewBuilder b)]) =
      _$TimelinePreview;

  String toJson() {
    return json
        .encode(serializers.serializeWith(TimelinePreview.serializer, this));
  }

  static TimelinePreview fromJson(String jsonString) {
    return serializers.deserializeWith(
        TimelinePreview.serializer, json.decode(jsonString));
  }

  static Serializer<TimelinePreview> get serializer =>
      _$timelinePreviewSerializer;
}
