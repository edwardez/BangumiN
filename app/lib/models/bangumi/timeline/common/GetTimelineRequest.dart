import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GetTimelineRequest.g.dart';

/// Class to represent possible request to get timeline
/// For source, currently munin only supports [TimelineSource.OnlyFriends]
/// and [TimelineSource.UserProfile]
/// Setting source to other values will request in unexpected behavior
abstract class GetTimelineRequest
    implements Built<GetTimelineRequest, GetTimelineRequestBuilder> {
  GetTimelineRequest._();

  TimelineSource get timelineSource;

  TimelineCategoryFilter get timelineCategoryFilter;

  /// Needs to be present if [timelineSource] is set to [TimelineSource.UserProfile]
  @nullable
  String get username;

  @memoized
  String get chineseName {
    /// Most people will stick with checking status from their friends only,
    /// there is no need to explicitly add source prefix for this type
    if (timelineSource == TimelineSource.OnlyFriends ||
        timelineSource == TimelineSource.UserProfile) {
      return timelineCategoryFilter.chineseName;
    }

    return '${timelineSource.chineseName} - ${timelineCategoryFilter.chineseName}';
  }

  factory GetTimelineRequest(
          [void Function(GetTimelineRequestBuilder) updates]) =
      _$GetTimelineRequest;

  String toJson() {
    return json
        .encode(serializers.serializeWith(GetTimelineRequest.serializer, this));
  }

  static GetTimelineRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        GetTimelineRequest.serializer, json.decode(jsonString));
  }

  static Serializer<GetTimelineRequest> get serializer =>
      _$getTimelineRequestSerializer;
}
