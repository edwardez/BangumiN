library bangumi_user_basic;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/BangumiUserAvatar.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiUserBaic.g.dart';

abstract class BangumiUserBasic
    implements Built<BangumiUserBasic, BangumiUserBasicBuilder> {
  BangumiUserBasic._();

  factory BangumiUserBasic([updates(BangumiUserBasicBuilder b)]) =
      _$BangumiUserBasic;

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'url')
  String get url;

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
        .encode(serializers.serializeWith(BangumiUserBasic.serializer, this));
  }

  static BangumiUserBasic fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiUserBasic.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiUserBasic> get serializer =>
      _$bangumiUserBasicSerializer;
}
