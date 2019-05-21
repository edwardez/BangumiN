import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BangumiCookieCredentials.g.dart';

abstract class BangumiCookieCredentials
    implements
        Built<BangumiCookieCredentials, BangumiCookieCredentialsBuilder> {
  BangumiCookieCredentials._();

  factory BangumiCookieCredentials(
          [updates(BangumiCookieCredentialsBuilder b)]) =
      _$BangumiCookieCredentials;

  @BuiltValueField(wireName: 'authCookie')
  String get authCookie;

  @BuiltValueField(wireName: 'sessionCookie')
  String get sessionCookie;

  @BuiltValueField(wireName: 'userAgent')
  String get userAgent;

  String toJson() {
    return json.encode(
        serializers.serializeWith(BangumiCookieCredentials.serializer, this));
  }

  static BangumiCookieCredentials fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiCookieCredentials.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiCookieCredentials> get serializer =>
      _$bangumiCookieCredentialsSerializer;
}
