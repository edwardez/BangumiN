import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'NetworkServiceTagLink.g.dart';

abstract class NetworkServiceTagLink
    implements
        NetworkServiceTag,
        Built<NetworkServiceTagLink, NetworkServiceTagLinkBuilder> {
  NetworkServiceTagLink._();

  String get link;

  factory NetworkServiceTagLink(
          [void Function(NetworkServiceTagLinkBuilder) updates]) =
      _$NetworkServiceTagLink;

  String toJson() {
    return json.encode(
        serializers.serializeWith(NetworkServiceTagLink.serializer, this));
  }

  static NetworkServiceTagLink fromJson(String jsonString) {
    return serializers.deserializeWith(
        NetworkServiceTagLink.serializer, json.decode(jsonString));
  }

  static Serializer<NetworkServiceTagLink> get serializer =>
      _$networkServiceTagLinkSerializer;
}
