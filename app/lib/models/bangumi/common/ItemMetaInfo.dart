import 'package:built_value/built_value.dart';

/// a base TimelineFeed interface
abstract class ItemMetaInfo {
  /// Updated at epoch time in milliseconds
  int get updatedAt;

  /// user nick name
  String get nickName;

  /// TODO: replace avatarImageUrl with images
  @nullable
  /// user avatar image url
  String get avatarImageUrl;

  /// user name, can only have digit and alphabetic
  String get username;

  @nullable
  String get actionName;
}
