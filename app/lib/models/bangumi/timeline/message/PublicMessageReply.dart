import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'PublicMessageReply.g.dart';

abstract class PublicMessageReply
    implements Built<PublicMessageReply, PublicMessageReplyBuilder> {
  /// author of the reply.
  BangumiUserBasic get author;

  /// Reply content in html.
  String get contentHtml;

  /// Reply content in plainText.
  String get contentText;

  PublicMessageReply._();

  factory PublicMessageReply(
          [void Function(PublicMessageReplyBuilder) updates]) =
      _$PublicMessageReply;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PublicMessageReply.serializer, this));
  }

  static PublicMessageReply fromJson(String jsonString) {
    return serializers.deserializeWith(
        PublicMessageReply.serializer, json.decode(jsonString));
  }

  static Serializer<PublicMessageReply> get serializer =>
      _$publicMessageReplySerializer;
}
