import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiSearchResponse.g.dart';

abstract class BangumiSearchResponse
    implements Built<BangumiSearchResponse, BangumiSearchResponseBuilder> {
  @BuiltValueField(wireName: 'results')
  int get totalCount;

  /// Accumulated number of results that have been requested so far
  /// This is used to track pagination. This field is needed because bangumi
  /// won't always return number of results as requested
  /// i.e. A api call requests 10 results, but bangumi might return 8 results.
  /// And these 8 results might contain previous search results
  /// Guessing it's because some subjects are soft deleted from their database
  /// and they are not handling it properly?
  @nullable
  int get requestedResults;

  /// This field it a [BuiltMap] instead of a [BuiltList] because Bangumi returns
  /// result randomly sometimes and we want to eliminate duplicates
  /// See also explanation in [requestedResults]
  /// BuiltMap guarantees the order so we can iterate it as a [List] by accessing
  /// [resultsAsList]
  @nullable
  BuiltMap<int, SearchResult> get results;

  @memoized
  List<SearchResult> get resultsAsList {
    return results.values.toList();
  }

  @memoized
  bool get hasReachedEnd {
    return requestedResults >= totalCount;
  }

  BangumiSearchResponse rebuild(void updates(BangumiSearchResponseBuilder b));

  BangumiSearchResponseBuilder toBuilder();

  BangumiSearchResponse._();

  factory BangumiSearchResponse([updates(BangumiSearchResponseBuilder b)]) =>
      _$BangumiSearchResponse((b) => b
        ..totalCount = 0
        ..requestedResults = 0
        ..results.replace(BuiltMap<int, SearchResult>())
        ..update(updates));

  String toJson() {
    return json.encode(
        serializers.serializeWith(BangumiSearchResponse.serializer, this));
  }

  static BangumiSearchResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiSearchResponse.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiSearchResponse> get serializer =>
      _$bangumiSearchResponseSerializer;
}
