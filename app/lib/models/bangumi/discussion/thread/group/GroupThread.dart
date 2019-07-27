import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/OriginalPost.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/utils.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GroupThread.g.dart';

/// A single thread in a group.
abstract class GroupThread
    implements BangumiThread, Built<GroupThread, GroupThreadBuilder> {
  @override

  /// Title of the thread, as set by the original posters.
  String get title;

  /// Name of the group.
  String get groupName;

  OriginalPost get initialPost;

  /// A flattened list of all posts.
  @override
  @memoized
  List<Post> get normalModePosts {
    return mergePostsWithMainPostReplies([initialPost], mainPostReplies);
  }

  @override
  @memoized
  List<Post> get hasNewestReplyFirstNestedPosts {
    return mergePostsWithHasNewestReplyFirstNestedPosts(
      [initialPost], mainPostReplies,);
  }

  @override
  @memoized
  List<Post> get newestFirstFlattenedPosts {
    return flattenedReverseOrderMainPostReplies([initialPost], mainPostReplies);
  }

  GroupThread._();

  factory GroupThread([void Function(GroupThreadBuilder) updates]) =
      _$GroupThread;

  String toJson() {
    return json.encode(serializers.serializeWith(GroupThread.serializer, this));
  }

  static GroupThread fromJson(String jsonString) {
    return serializers.deserializeWith(
        GroupThread.serializer, json.decode(jsonString));
  }

  static Serializer<GroupThread> get serializer => _$groupThreadSerializer;
}

enum PostType {
  InitialGroupPost,
  InitialBlogPost,
  InitialSubjectPost,
  MainPostReply,
  SubPostReply
}
