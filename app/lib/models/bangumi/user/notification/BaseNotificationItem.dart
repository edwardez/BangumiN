import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';

part 'BaseNotificationItem.g.dart';

@BuiltValue(instantiable: false)
abstract class BaseNotificationItem {
  /// ID of the notification item.
  int get id;

  /// User who initiated this notification.
  BangumiUserBasic get initiator;

  /// Body content of the notification in html, initiator is not included.
  /// For example: "在你的日志 test 中发表了新回复"
  String get bodyContentHtml;

  BaseNotificationItem rebuild(void updates(BaseNotificationItemBuilder b));

  BaseNotificationItemBuilder toBuilder();
}
