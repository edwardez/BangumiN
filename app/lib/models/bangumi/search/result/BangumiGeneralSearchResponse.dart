import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiGeneralSearchResponse.g.dart';

/// A general-purpose SearchResponse model
abstract class BangumiGeneralSearchResponse
    implements
        BangumiSearchResponse,
        Built<BangumiGeneralSearchResponse,
            BangumiGeneralSearchResponseBuilder> {
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
  /// [resultsToList]
  @nullable
  BuiltMap<int, SearchResultItem> get results;

  @memoized
  List<SearchResultItem> get resultsToList => results.values.toList();

  @override
  @memoized
  bool get hasReachedEnd {
    return requestedResults >= totalCount;
  }

  BangumiGeneralSearchResponse rebuild(
      void updates(BangumiGeneralSearchResponseBuilder b));

  BangumiGeneralSearchResponseBuilder toBuilder();

  BangumiGeneralSearchResponse._();

  factory BangumiGeneralSearchResponse(
          [updates(BangumiGeneralSearchResponseBuilder b)]) =>
      _$BangumiGeneralSearchResponse((b) => b
        ..totalCount = 0
        ..requestedResults = 0
        ..results.replace(BuiltMap<int, SearchResultItem>())
        ..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(
        BangumiGeneralSearchResponse.serializer, this));
  }

  static BangumiGeneralSearchResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiGeneralSearchResponse.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiGeneralSearchResponse> get serializer =>
      _$bangumiGeneralSearchResponseSerializer;
}
