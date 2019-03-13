import 'package:built_value/built_value.dart';

part 'TimelineUserInfo.g.dart';

abstract class TimelineUserInfo
    implements Built<TimelineUserInfo, TimelineUserInfoBuilder> {
  /// due to the limitation of bangumi, this has to be a string
  /// it's a relative time, i.e. xx minutes ago
  String get updatedAt;

  /// user nick name
  String get nickName;

  /// user avatar image url
  String get avatarImageUrl;

  /// user id, can only have digit and alphabetic
  String get id;

  String get actionName;

  TimelineUserInfo._();

  factory TimelineUserInfo([updates(TimelineUserInfoBuilder b)]) =
      _$TimelineUserInfo;
}
