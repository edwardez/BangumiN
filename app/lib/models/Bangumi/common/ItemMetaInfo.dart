import 'package:built_value/built_value.dart';

/// a base TimelineFeed interface
abstract class ItemMetaInfo {
  /// due to the limitation of bangumi, this has to be a string
  /// it's a relative time, i.e. xx minutes ago
  String get updatedAt;

  /// user nick name
  String get nickName;

  /// TODO: replace avatarImageUrl with images
  @nullable

  /// user avatar image url
  String get avatarImageUrl;

  /// user id, can only have digit and alphabetic
  String get userId;

  @nullable
  String get actionName;
}
