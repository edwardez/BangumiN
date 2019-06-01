import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserAvatar.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiUserSmall.g.dart';

abstract class BangumiUserSmall
    implements Built<BangumiUserSmall, BangumiUserSmallBuilder> {
  BangumiUserSmall._();

  factory BangumiUserSmall([updates(BangumiUserSmallBuilder b)]) =
  _$BangumiUserSmall;

  /// Unique identifier for bangumi user as a pure digit
  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'url')
  String get url;

  /// Unique identifier for bangumi user
  /// It can only contain number, letter and underscore
  /// https://bgm.tv/group/topic/5525
  /// "用户名允许使用以字母开头的包括字母、数字或下划线的字符串。"
  /// Once user has set username, bangumi prefers to display username but id
  /// can still be used as a identifier
  @BuiltValueField(wireName: 'username')
  String get username;

  @BuiltValueField(wireName: 'nickname')
  String get nickname;

  @BuiltValueField(wireName: 'avatar')
  BangumiUserAvatar get avatar;

  @BuiltValueField(wireName: 'sign')
  String get sign;

  @BuiltValueField(wireName: 'usergroup')
  int get userGroup;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BangumiUserSmall.serializer, this));
  }

  static BangumiUserSmall fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiUserSmall.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiUserSmall> get serializer =>
      _$bangumiUserSmallSerializer;
}
