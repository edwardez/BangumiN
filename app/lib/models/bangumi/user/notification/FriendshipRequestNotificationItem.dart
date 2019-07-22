import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'FriendshipRequestNotificationItem.g.dart';

abstract class FriendshipRequestNotificationItem
    implements
        Built<FriendshipRequestNotificationItem,
            FriendshipRequestNotificationItemBuilder>,
        BaseNotificationItem {
  FriendshipRequestNotificationItem._();

  factory FriendshipRequestNotificationItem(
          [void Function(FriendshipRequestNotificationItemBuilder) updates]) =
      _$FriendshipRequestNotificationItem;

  String toJson() {
    return json.encode(serializers.serializeWith(
        FriendshipRequestNotificationItem.serializer, this));
  }

  static FriendshipRequestNotificationItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        FriendshipRequestNotificationItem.serializer, json.decode(jsonString));
  }

  static Serializer<FriendshipRequestNotificationItem> get serializer =>
      _$friendshipRequestNotificationItemSerializer;
}
