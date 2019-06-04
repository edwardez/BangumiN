import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/OriginalPost.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadParentSubject.dart';
import 'package:munin/models/bangumi/discussion/thread/common/utils.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectTopicThread.g.dart';

abstract class SubjectTopicThread
    implements
        BangumiThread,
        Built<SubjectTopicThread, SubjectTopicThreadBuilder> {
  @override

  /// Title of the thread, as set by the original posters.
  String get title;

  OriginalPost get originalPost;

  ///  Parent subject that thread is related to.
  ThreadParentSubject get parentSubject;

  /// A flattened list of all posts.
  @override
  @memoized
  List<Post> get posts {
    return addFlattenedMainPostReplies([originalPost], mainPostReplies);
  }

  SubjectTopicThread._();

  factory SubjectTopicThread(
          [void Function(SubjectTopicThreadBuilder) updates]) =
      _$SubjectTopicThread;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectTopicThread.serializer, this));
  }

  static SubjectTopicThread fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectTopicThread.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectTopicThread> get serializer =>
      _$subjectTopicThreadSerializer;
}
