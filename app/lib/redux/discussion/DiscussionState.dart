import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'DiscussionState.g.dart';

abstract class DiscussionState
    implements Built<DiscussionState, DiscussionStateBuilder> {
  BuiltMap<GetDiscussionRequest, GetDiscussionResponse> get results;

  @nullable
  BuiltMap<GetDiscussionRequest, LoadingStatus>
  get getDiscussionRequestStatus;

  bool shouldFetchResponse(GetDiscussionRequest request) {
    return results[request] == null ||
        results[request].isStale;
  }

  factory DiscussionState([updates(DiscussionStateBuilder b)]) =>
      _$DiscussionState((b) => b
        ..results.replace(
            BuiltMap<GetDiscussionRequest, GetDiscussionResponse>())
        ..getDiscussionRequestStatus
            .replace(BuiltMap<GetDiscussionRequest, LoadingStatus>())
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
