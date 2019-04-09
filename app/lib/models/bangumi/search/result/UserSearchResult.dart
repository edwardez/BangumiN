import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'UserSearchResult.g.dart';

abstract class UserSearchResult
    implements SearchResult, Built<UserSearchResult, UserSearchResultBuilder> {
  @override
  SearchType get type;

  factory UserSearchResult([updates(UserSearchResultBuilder b)]) =
      _$UserSearchResult;

  UserSearchResult._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(UserSearchResult.serializer, this));
  }

  static UserSearchResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserSearchResult.serializer, json.decode(jsonString));
  }

  static Serializer<UserSearchResult> get serializer =>
      _$userSearchResultSerializer;
}
