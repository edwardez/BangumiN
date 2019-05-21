import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiUserIdentity.g.dart';

abstract class BangumiUserIdentity
    implements Built<BangumiUserIdentity, BangumiUserIdentityBuilder> {
  BangumiUserIdentity._();

  factory BangumiUserIdentity([updates(BangumiUserIdentityBuilder b)]) =
      _$BangumiUserIdentity;

  @BuiltValueField(wireName: 'access_token')
  String get accessToken;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'expires')
  int get expires;

  @BuiltValueField(wireName: 'scope')
  @nullable
  String get scope;

  @BuiltValueField(wireName: 'user_id')
  int get id;

  String toJson() {
    return json.encode(
        serializers.serializeWith(BangumiUserIdentity.serializer, this));
  }

  static BangumiUserIdentity fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiUserIdentity.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiUserIdentity> get serializer =>
      _$bangumiUserIdentitySerializer;
}
