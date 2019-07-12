import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';

part 'GroupDiscussionItem.g.dart';

abstract class GroupDiscussionItem
    implements
        Built<GroupDiscussionItem, GroupDiscussionItemBuilder>,
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

  GroupDiscussionItem._();

  factory GroupDiscussionItem([updates(GroupDiscussionItemBuilder b)]) =
  _$GroupDiscussionItem;

  static Serializer<GroupDiscussionItem> get serializer =>
      _$groupDiscussionItemSerializer;
}
