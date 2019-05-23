import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

part 'FriendshipCreationSingle.g.dart';

abstract class FriendshipCreationSingle
    implements
        Built<FriendshipCreationSingle, FriendshipCreationSingleBuilder>,
        TimelineFeed {
  FeedMetaInfo get user;

  String get friendNickName;

  Images get friendAvatar;

  String get friendId;

  FriendshipCreationSingle._();

  factory FriendshipCreationSingle(
          [updates(FriendshipCreationSingleBuilder b)]) =
      _$FriendshipCreationSingle;

  static Serializer<FriendshipCreationSingle> get serializer =>
      _$friendshipCreationSingleSerializer;
}
