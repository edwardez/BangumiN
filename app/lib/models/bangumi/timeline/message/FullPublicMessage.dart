import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/message/PublicMessageReply.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'FullPublicMessage.g.dart';

/// A full [PublicMessageNormal] that's with [PublicMessageNormal] and its
/// [PublicMessageReply].
abstract class FullPublicMessage
    implements Built<FullPublicMessage, FullPublicMessageBuilder> {
  PublicMessageNormal get mainMessage;

  /// Al replies to [mainMessage].
  BuiltList<PublicMessageReply> get replies;

  FullPublicMessage._();

  factory FullPublicMessage([void Function(FullPublicMessageBuilder) updates]) =
      _$FullPublicMessage;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FullPublicMessage.serializer, this));
  }

  static FullPublicMessage fromJson(String jsonString) {
    return serializers.deserializeWith(
        FullPublicMessage.serializer, json.decode(jsonString));
  }

  static Serializer<FullPublicMessage> get serializer =>
      _$fullPublicMessageSerializer;
}
