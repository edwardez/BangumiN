import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GeneralNotificationItem.g.dart';

/// A general-purpose notification item.
abstract class GeneralNotificationItem
    implements
        Built<GeneralNotificationItem, GeneralNotificationItemBuilder>,
        BaseNotificationItem {
  GeneralNotificationItem._();

  factory GeneralNotificationItem(
          [void Function(GeneralNotificationItemBuilder) updates]) =
      _$GeneralNotificationItem;

  String toJson() {
    return json.encode(
        serializers.serializeWith(GeneralNotificationItem.serializer, this));
  }

  static GeneralNotificationItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        GeneralNotificationItem.serializer, json.decode(jsonString));
  }

  static Serializer<GeneralNotificationItem> get serializer =>
      _$generalNotificationItemSerializer;
}
