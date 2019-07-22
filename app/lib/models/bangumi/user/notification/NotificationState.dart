import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'NotificationState.g.dart';

abstract class NotificationState
    implements Built<NotificationState, NotificationStateBuilder> {
  /// All notifications.
  ///
  /// Null indicates this is not loaded into store.
  @nullable
  BuiltList<BaseNotificationItem> get allNotificationItems;

  /// Unread notifications.
  ///
  /// Null indicates this is not loaded into store.
  @nullable
  BuiltList<BaseNotificationItem> get unreadNotificationItems;

  NotificationState._();

  factory NotificationState(
          [void Function(NotificationStateBuilder) updates]) =>
      _$NotificationState();

  String toJson() {
    return json
        .encode(serializers.serializeWith(NotificationState.serializer, this));
  }

  static NotificationState fromJson(String jsonString) {
    return serializers.deserializeWith(
        NotificationState.serializer, json.decode(jsonString));
  }

  static Serializer<NotificationState> get serializer =>
      _$notificationStateSerializer;
}
