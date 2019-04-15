import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'DiscussionState.g.dart';

abstract class DiscussionState
    implements Built<DiscussionState, DiscussionStateBuilder> {
  BuiltMap<FetchDiscussionRequest, FetchDiscussionResponse> get results;

  @nullable
  BuiltMap<FetchDiscussionRequest, LoadingStatus>
      get fetchDiscussionRequestStatus;

  bool shouldFetchResponse(FetchDiscussionRequest fetchDiscussionRequest) {
    return results[fetchDiscussionRequest] == null ||
        results[fetchDiscussionRequest].isStale;
  }

  factory DiscussionState([updates(DiscussionStateBuilder b)]) =>
      _$DiscussionState((b) => b
        ..results.replace(
            BuiltMap<FetchDiscussionRequest, FetchDiscussionResponse>())
        ..fetchDiscussionRequestStatus
            .replace(BuiltMap<FetchDiscussionRequest, LoadingStatus>())
        ..update(updates));

  DiscussionState._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(DiscussionState.serializer, this));
  }

  static DiscussionState fromJson(String jsonString) {
    return serializers.deserializeWith(
        DiscussionState.serializer, json.decode(jsonString));
  }

  static Serializer<DiscussionState> get serializer =>
      _$discussionStateSerializer;
}
