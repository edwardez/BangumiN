import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'FeedChunks.g.dart';

abstract class FeedChunks implements Built<FeedChunks, FeedChunksBuilder> {
  BuiltList<TimelineFeed> get first;

  /// reserved, currently not in use
  BuiltList<TimelineFeed> get second;

  @memoized
  int get feedsCount {
    return first.length + second.length;
  }

  @memoized
  int get firstChunkMaxIdOrNull {
    return firstOrNullInBuiltList<TimelineFeed>(first)?.user?.feedId;
  }

  @memoized
  int get firstChunkMinIdOrNull {
    return lastOrNullInBuiltList<TimelineFeed>(first)?.user?.feedId;
  }

  @memoized
  int get secondChunkMaxIdOrNull {
    return firstOrNullInBuiltList<TimelineFeed>(second)?.user?.feedId;
  }

  @memoized
  int get secondChunkMinIdOrNull {
    return lastOrNullInBuiltList<TimelineFeed>(second)?.user?.feedId;
  }

  /// returns null if
  TimelineFeed getFeedAt(int index) {
    if (index > feedsCount || feedsCount == 0) {
      return null;
    }
    if (index >= first.length) {
      return second[index - first.length];
    }

    return first[index];
  }

  FeedChunks._();

  factory FeedChunks([updates(FeedChunksBuilder b)]) => _$FeedChunks((b) => b
    ..first.replace(BuiltList<TimelineFeed>())
    ..second.replace(BuiltList<TimelineFeed>())
    ..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(FeedChunks.serializer, this));
  }

  static FeedChunks fromJson(String jsonString) {
    return serializers.deserializeWith(
        FeedChunks.serializer, json.decode(jsonString));
  }

  static Serializer<FeedChunks> get serializer => _$feedChunksSerializer;
}
