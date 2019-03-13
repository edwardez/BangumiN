import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'FriendshipCreationSingle.g.dart';

abstract class FriendshipCreationSingle
    implements
        Built<FriendshipCreationSingle, FriendshipCreationSingleBuilder> {
  TimelineUserInfo get user;

  String get friendNickName;

  String get friendAvatarImageUrl;

  int get friendId;

  FriendshipCreationSingle._();

  factory FriendshipCreationSingle(
          [updates(FriendshipCreationSingleBuilder b)]) =
      _$FriendshipCreationSingle;
}
