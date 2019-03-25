import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineFeed.dart';

part 'GroupJoinSingle.g.dart';

abstract class GroupJoinSingle
    implements Built<GroupJoinSingle, GroupJoinSingleBuilder>, TimelineFeed {
  FeedMetaInfo get user;

  String get groupCoverImageUrl;

  String get groupName;

  @nullable
  String get groupDescription;

  String get groupId;

  GroupJoinSingle._();

  factory GroupJoinSingle([updates(GroupJoinSingleBuilder b)]) =
      _$GroupJoinSingle;

  static Serializer<GroupJoinSingle> get serializer =>
      _$groupJoinSingleSerializer;
}
