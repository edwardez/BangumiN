import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:quiver/time.dart';

part 'FetchDiscussionResponse.g.dart';

abstract class FetchDiscussionResponse
    implements Built<FetchDiscussionResponse, FetchDiscussionResponseBuilder> {
  FetchDiscussionResponse._();

  static const Duration staleDataThreshold = anHour;

  /// This is a [BuiltSet] instead of a [BuiltList] considering [discussionItems]
  /// might need to be looked up
  BuiltSet<DiscussionItem> get discussionItems;

  /// The last time munin tries to fetch this response
  DateTime get lastFetchedTime;

  bool get isStale {
    return DateTime.now().difference(lastFetchedTime) >= staleDataThreshold;
  }

  @memoized
  BuiltList<DiscussionItem> get discussionItemsAsList {
    return this.discussionItems.toBuiltList();
  }

  factory FetchDiscussionResponse([updates(FetchDiscussionResponseBuilder b)]) =
      _$FetchDiscussionResponse;

  String toJson() {
    return json.encode(
        serializers.serializeWith(FetchDiscussionResponse.serializer, this));
  }

  static FetchDiscussionResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        FetchDiscussionResponse.serializer, json.decode(jsonString));
  }

  static Serializer<FetchDiscussionResponse> get serializer =>
      _$fetchDiscussionResponseSerializer;
}
