import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/discussion/enums/base.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GetDiscussionRequest.g.dart';

abstract class GetDiscussionRequest
    implements Built<GetDiscussionRequest, GetDiscussionRequestBuilder> {
  static const totalGetProgressRequestTypes = 5;
  static final defaultDiscussionLaunchPageType = GetDiscussionRequest((b) =>
  b
    ..discussionType = DiscussionType.Rakuen
    ..discussionFilter = RakuenTopicFilter.Unrestricted);

  static final List<GetDiscussionRequest> validGetDiscussionRequests = [
    defaultDiscussionLaunchPageType,
    defaultDiscussionLaunchPageType.rebuild((
        b) => b..discussionFilter = RakuenTopicFilter.AllGroups),
    defaultDiscussionLaunchPageType.rebuild((
        b) => b..discussionFilter = RakuenTopicFilter.Subject),
    defaultDiscussionLaunchPageType.rebuild((
        b) => b..discussionFilter = RakuenTopicFilter.Episode),
    defaultDiscussionLaunchPageType.rebuild((
        b) => b..discussionFilter = RakuenTopicFilter.Mono),
  ];

  DiscussionType get discussionType;

  DiscussionFilter get discussionFilter;

  /// Get current page index in discussion page
  /// Index must be consecutive and unique
  @memoized
  int get pageIndex {
    assert(discussionType == DiscussionType.Rakuen);

    if (discussionType == DiscussionType.Rakuen) {
      if (discussionFilter == RakuenTopicFilter.Unrestricted) {
        return 0;
      }

      if (discussionFilter == RakuenTopicFilter.AllGroups) {
        return 1;
      }

      if (discussionFilter == RakuenTopicFilter.Subject) {
        return 2;
      }

      if (discussionFilter == RakuenTopicFilter.Episode) {
        return 3;
      }

      if (discussionFilter == RakuenTopicFilter.Mono) {
        return 4;
      }
    }

    assert(false, '$this doesn\'t have a valid page index');

    return 0;
  }


  GetDiscussionRequest._();

  factory GetDiscussionRequest([updates(GetDiscussionRequestBuilder b)]) =
  _$GetDiscussionRequest;

  String toJson() {
    return json.encode(
        serializers.serializeWith(GetDiscussionRequest.serializer, this));
  }

  static GetDiscussionRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        GetDiscussionRequest.serializer, json.decode(jsonString));
  }

  static Serializer<GetDiscussionRequest> get serializer =>
      _$getDiscussionRequestSerializer;
}
