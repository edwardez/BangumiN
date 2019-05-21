import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/SearchResult.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'UserSearchResult.g.dart';

abstract class UserSearchResult
    implements SearchResult, Built<UserSearchResult, UserSearchResultBuilder> {
  @nullable
  @override
  @BuiltValueField(wireName: 'avatar')
  Images get images;

  /// User nickname
  @override
  @BuiltValueField(wireName: 'nickname')
  String get name;

  /// Canonical userName that can be used as the permanent primary key to find user
  /// in Bangumi, [id] must only contain digit
  @override
  int get id;

  /// Canonical userName that can be used as the permanent primary key to find user
  /// in Bangumi, [username] may contain letters or digit
  String get username;

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

  static UserSearchResult fromBangumiUserBasic(
      BangumiUserBasic bangumiUserBasic) {
    return UserSearchResult((b) =>
    b
      ..id = bangumiUserBasic.id
      ..name = bangumiUserBasic.nickname
      ..username = bangumiUserBasic.username
      ..images.replace(Images.fromBangumiUserAvatar(bangumiUserBasic.avatar))
      ..type = SearchType.User);
  }

  static Serializer<UserSearchResult> get serializer =>
      _$userSearchResultSerializer;
}
