import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/search/SearchRequest.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SearchState.g.dart';

abstract class SearchState implements Built<SearchState, SearchStateBuilder> {
  BuiltMap<SearchRequest, BangumiSearchResponse> get results;

  @nullable
  BuiltMap<SearchRequest, LoadingStatus> get searchRequestsStatus;

  factory SearchState([updates(SearchStateBuilder b)]) => _$SearchState((b) => b
    ..results.replace(BuiltMap<SearchRequest, BangumiSearchResponse>())
    ..searchRequestsStatus.replace(BuiltMap<SearchRequest, LoadingStatus>())
    ..update(updates));

  SearchState._();

  String toJson() {
    return json.encode(serializers.serializeWith(SearchState.serializer, this));
  }

  static SearchState fromJson(String jsonString) {
    return serializers.deserializeWith(
        SearchState.serializer, json.decode(jsonString));
  }

  static Serializer<SearchState> get serializer => _$searchStateSerializer;
}
