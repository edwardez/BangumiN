import 'package:built_value/built_value.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';

part 'GroupJoinSingle.g.dart';

abstract class GroupJoinSingle
    implements Built<GroupJoinSingle, GroupJoinSingleBuilder> {
  TimelineUserInfo get user;

  String get groupCoverImageUrl;

  String get groupName;

  String get groupDescription;

  String get groupId;

  GroupJoinSingle._();

  factory GroupJoinSingle([updates(GroupJoinSingleBuilder b)]) =
      _$GroupJoinSingle;
}
