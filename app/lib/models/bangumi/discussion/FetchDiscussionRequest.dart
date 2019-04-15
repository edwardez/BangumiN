import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/discussion/enums/base.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'FetchDiscussionRequest.g.dart';

abstract class FetchDiscussionRequest
    implements Built<FetchDiscussionRequest, FetchDiscussionRequestBuilder> {
  FetchDiscussionRequest._();

  DiscussionType get discussionType;

  DiscussionFilter get discussionFilter;

  static BuiltList<FetchDiscussionRequest> allRakuenRequests() {
    FetchDiscussionRequest base = FetchDiscussionRequest((b) => b
      ..discussionType = DiscussionType.Rakuen
      ..discussionFilter = RakuenTopicFilter.Unrestricted);

    final List<FetchDiscussionRequest> allRakuenRequests = [
      base.rebuild((b) => b..discussionFilter = RakuenTopicFilter.Unrestricted),
      base.rebuild((b) => b..discussionFilter = RakuenTopicFilter.AllGroups),
      base.rebuild((b) => b..discussionFilter = RakuenTopicFilter.Subject),
      base.rebuild((b) => b..discussionFilter = RakuenTopicFilter.Episode),
      base.rebuild((b) => b..discussionFilter = RakuenTopicFilter.Mono),
    ];

    return BuiltList<FetchDiscussionRequest>(allRakuenRequests);
  }

  factory FetchDiscussionRequest([updates(FetchDiscussionRequestBuilder b)]) =
      _$FetchDiscussionRequest;

  String toJson() {
    return json.encode(
        serializers.serializeWith(FetchDiscussionRequest.serializer, this));
  }

  static FetchDiscussionRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        FetchDiscussionRequest.serializer, json.decode(jsonString));
  }

  static Serializer<FetchDiscussionRequest> get serializer =>
      _$fetchDiscussionRequestSerializer;
}
