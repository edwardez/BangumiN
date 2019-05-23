import 'package:built_value/built_value.dart';
import 'package:munin/models/bangumi/common/Images.dart';

/// a base TimelineFeed interface
abstract class ItemMetaInfo {
  /// Updated at epoch time in milliseconds
  int get updatedAt;

  /// user nick name
  String get nickName;

  /// User avatars
  Images get avatars;

  /// user name, can only have digit and alphabetic
  String get username;

  @nullable
  String get actionName;
}
