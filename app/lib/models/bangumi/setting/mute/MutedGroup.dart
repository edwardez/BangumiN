import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/discussion/GroupDiscussionPost.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'MutedGroup.g.dart';

abstract class MutedGroup implements Built<MutedGroup, MutedGroupBuilder> {
  MutedGroup._();

  String get groupNickname;

  String get groupId;

  /// Currently not in use and not properly populated
  @nullable
  BangumiImage get groupIcon;

  factory MutedGroup.fromGroupDiscussionPost(
      GroupDiscussionPost groupDiscussionPost) {
    return MutedGroup((b) => b
      ..groupNickname = groupDiscussionPost.subTitle
      ..groupId = groupDiscussionPost.postedGroupId);
  }

  factory MutedGroup([updates(MutedGroupBuilder b)]) =>
      _$MutedGroup((b) => b..update(updates));

  String toJson() {
    return json.encode(serializers.serializeWith(MutedGroup.serializer, this));
  }

  static MutedGroup fromJson(String jsonString) {
    return serializers.deserializeWith(
        MutedGroup.serializer, json.decode(jsonString));
  }

  static Serializer<MutedGroup> get serializer => _$mutedGroupSerializer;
}
