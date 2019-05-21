import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SearchRequest.g.dart';

abstract class SearchRequest
    implements Built<SearchRequest, SearchRequestBuilder> {
  SearchRequest._();

  String get query;

  SearchType get searchType;

  factory SearchRequest([updates(SearchRequestBuilder b)]) = _$SearchRequest;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SearchRequest.serializer, this));
  }

  static SearchRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        SearchRequest.serializer, json.decode(jsonString));
  }

  static Serializer<SearchRequest> get serializer => _$searchRequestSerializer;
}
