import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';

part 'GroupDiscussionPost.g.dart';

abstract class GroupDiscussionPost
    implements
        Built<GroupDiscussionPost, GroupDiscussionPostBuilder>,
        DiscussionItem {
  @nullable
  String get originalPosterUsername;

  /// Secondary user identifier, for Rakuen posts, `originalPosterUsername` is
  /// not available, instead, there is `originalPosterUserId`
  /// User id is parsed from path in user icon
  /// meaning for user with default icon, this will be null
  @nullable
  int get originalPosterUserId;

  String get postedGroupId;

  GroupDiscussionPost._();

  factory GroupDiscussionPost([updates(GroupDiscussionPostBuilder b)]) =
      _$GroupDiscussionPost;

  static Serializer<GroupDiscussionPost> get serializer =>
      _$groupDiscussionPostSerializer;
}
