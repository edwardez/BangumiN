import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:quiver/time.dart';

part 'GetDiscussionResponse.g.dart';

abstract class GetDiscussionResponse
    implements Built<GetDiscussionResponse, GetDiscussionResponseBuilder> {
  GetDiscussionResponse._();

  static const Duration staleDataThreshold = anHour;

  /// This is a [BuiltSet] instead of a [BuiltList] considering [discussionItems]
  /// might need to be looked up
  BuiltSet<DiscussionItem> get discussionItems;

  /// The last time munin tries to get this response
  DateTime get appLastUpdatedAt;

  bool get isStale {
    return DateTime.now().difference(appLastUpdatedAt) >= staleDataThreshold;
  }

  @memoized
  BuiltList<DiscussionItem> get discussionItemsAsList {
    return this.discussionItems.toBuiltList();
  }

  factory GetDiscussionResponse([updates(GetDiscussionResponseBuilder b)]) =
      _$GetDiscussionResponse;

  String toJson() {
    return json.encode(
        serializers.serializeWith(GetDiscussionResponse.serializer, this));
  }

  static GetDiscussionResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        GetDiscussionResponse.serializer, json.decode(jsonString));
  }

  static Serializer<GetDiscussionResponse> get serializer =>
      _$getDiscussionResponseSerializer;
}
