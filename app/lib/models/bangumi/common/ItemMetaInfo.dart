import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';

/// a base TimelineFeed interface
abstract class ItemMetaInfo {
  /// Updated at epoch time in milliseconds
  int get updatedAt;

  /// user nick name
  String get nickName;

  /// User avatars
  BangumiImage get avatar;

  /// user name, can only have digit and alphabetic
  String get username;

  @nullable
  String get actionName;
}
