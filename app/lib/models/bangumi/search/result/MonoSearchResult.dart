import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'MonoSearchResult.g.dart';

abstract class MonoSearchResult
    implements
        SearchResultItem,
        Built<MonoSearchResult, MonoSearchResultBuilder> {
  BuiltList<String> get miscInfo;

  @BuiltValueField(wireName: 'name_cn')
  String get nameCn;

  factory MonoSearchResult([updates(MonoSearchResultBuilder b)]) =
      _$MonoSearchResult;

  MonoSearchResult._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(MonoSearchResult.serializer, this));
  }

  static MonoSearchResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        MonoSearchResult.serializer, json.decode(jsonString));
  }

  static Serializer<MonoSearchResult> get serializer =>
      _$monoSearchResultSerializer;
}
