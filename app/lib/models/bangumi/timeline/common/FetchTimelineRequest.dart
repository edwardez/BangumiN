import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'FetchTimelineRequest.g.dart';

/// Class to represent possible request to fetch timeline
/// For source, currently munin only supports [TimelineSource.FriendsOnly]
/// Setting source to other values will request in unexpected behavior
abstract class FetchTimelineRequest
    implements Built<FetchTimelineRequest, FetchTimelineRequestBuilder> {
  FetchTimelineRequest._();

  TimelineSource get timelineSource;

  TimelineCategoryFilter get timelineCategoryFilter;

  @memoized
  String get chineseName {
    /// Most people will stick with checking status from their friends only,
    /// there is no need to explicitly add source prefix for this type
    if (timelineSource == TimelineSource.FriendsOnly) {
      return timelineCategoryFilter.chineseName;
    }

    return '${timelineSource.chineseName} - ${timelineCategoryFilter.chineseName}';
  }

  factory FetchTimelineRequest(
          [void Function(FetchTimelineRequestBuilder) updates]) =
      _$FetchTimelineRequest;

  String toJson() {
    return json.encode(
        serializers.serializeWith(FetchTimelineRequest.serializer, this));
  }

  static FetchTimelineRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        FetchTimelineRequest.serializer, json.decode(jsonString));
  }

  static Serializer<FetchTimelineRequest> get serializer =>
      _$fetchTimelineRequestSerializer;
}
