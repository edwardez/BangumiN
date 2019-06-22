import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/SearchResultItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'UserSearchResultItem.g.dart';

abstract class UserSearchResultItem
    implements
        SearchResultItem,
        Built<UserSearchResultItem, UserSearchResultItemBuilder> {
  @nullable
  @override
  @BuiltValueField(wireName: 'avatar')
  BangumiImage get image;

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

  factory UserSearchResultItem([updates(UserSearchResultItemBuilder b)]) =
      _$UserSearchResultItem;

  UserSearchResultItem._();

  String toJson() {
    return json.encode(
        serializers.serializeWith(UserSearchResultItem.serializer, this));
  }

  static UserSearchResultItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserSearchResultItem.serializer, json.decode(jsonString));
  }

  static UserSearchResultItem fromBangumiUserSmall(
      BangumiUserSmall bangumiUserSmall) {
    return UserSearchResultItem((b) => b
      ..id = bangumiUserSmall.id
      ..name = bangumiUserSmall.nickname
      ..username = bangumiUserSmall.username
      ..image
          .replace(BangumiImage.fromBangumiUserAvatar(bangumiUserSmall.avatar))
      ..type = SearchType.User);
  }

  static Serializer<UserSearchResultItem> get serializer =>
      _$userSearchResultItemSerializer;
}
