import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'NetworkServiceTagPlainText.g.dart';

abstract class NetworkServiceTagPlainText
    implements
        NetworkServiceTag,
        Built<NetworkServiceTagPlainText, NetworkServiceTagPlainTextBuilder> {
  NetworkServiceTagPlainText._();

  factory NetworkServiceTagPlainText(
          [void Function(NetworkServiceTagPlainTextBuilder) updates]) =
      _$NetworkServiceTagPlainText;

  String toJson() {
    return json.encode(
        serializers.serializeWith(NetworkServiceTagPlainText.serializer, this));
  }

  static NetworkServiceTagPlainText fromJson(String jsonString) {
    return serializers.deserializeWith(
        NetworkServiceTagPlainText.serializer, json.decode(jsonString));
  }

  static Serializer<NetworkServiceTagPlainText> get serializer =>
      _$networkServiceTagPlainTextSerializer;
}
