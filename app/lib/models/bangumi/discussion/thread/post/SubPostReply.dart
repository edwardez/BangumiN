import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubPostReply.g.dart';

/// A reply to the [MainPostReply], this is the last level in a thread.
/// [SubPostReply] is attached to the [MainPostReply] as a sub floor.
abstract class SubPostReply
    implements Post, Built<SubPostReply, SubPostReplyBuilder> {
  /// Main post id this sub-reply is sent against.
  int get mainPostId;

  /// Sub post sequential number of this post.
  /// This the inner sequential number under the main post.
  /// For example, if it's the second reply to a post in third floor, then
  /// [subSequentialNumber] is 2.
  int get subSequentialNumber;

  /// [sequentialName] is made up of [subSequentialNumber] and [mainSequentialNumber].
  @override
  String get sequentialName {
    return '#$mainSequentialNumber-$subSequentialNumber';
  }

  SubPostReply._();

  factory SubPostReply([void Function(SubPostReplyBuilder) updates]) =
  _$SubPostReply;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubPostReply.serializer, this));
  }

  static SubPostReply fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubPostReply.serializer, json.decode(jsonString));
  }

  static Serializer<SubPostReply> get serializer => _$subPostReplySerializer;
}
