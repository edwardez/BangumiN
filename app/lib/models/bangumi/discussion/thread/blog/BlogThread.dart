import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogContent.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/utils.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BlogThread.g.dart';

abstract class BlogThread
    implements BangumiThread, Built<BlogThread, BlogThreadBuilder> {
  BlogContent get blogContent;

  /// A flattened list of all posts.
  @memoized
  List<Post> get posts {
    return addFlattenedMainPostReplies([], mainPostReplies);
  }

  BlogThread._();

  factory BlogThread([void Function(BlogThreadBuilder) updates]) = _$BlogThread;

  String toJson() {
    return json.encode(serializers.serializeWith(BlogThread.serializer, this));
  }

  static BlogThread fromJson(String jsonString) {
    return serializers.deserializeWith(
        BlogThread.serializer, json.decode(jsonString));
  }

  static Serializer<BlogThread> get serializer => _$blogThreadSerializer;
}
