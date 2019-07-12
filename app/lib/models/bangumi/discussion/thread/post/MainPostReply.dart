import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'MainPostReply.g.dart';

/// A reply to the [InitialGroupPost], [MainPostReply] is attached to the thread
/// as a main floor.
abstract class MainPostReply
    implements Post, Built<MainPostReply, MainPostReplyBuilder> {
  @override
  String get sequentialName {
    return '#$mainSequentialNumber';
  }

  MainPostReply._();

  /// A list of replies that are attached to the [MainPostReply].
  BuiltList<SubPostReply> get subReplies;

  factory MainPostReply([void Function(MainPostReplyBuilder) updates]) =
      _$MainPostReply;

  String toJson() {
    return json
        .encode(serializers.serializeWith(MainPostReply.serializer, this));
  }

  static MainPostReply fromJson(String jsonString) {
    return serializers.deserializeWith(
        MainPostReply.serializer, json.decode(jsonString));
  }

  static Serializer<MainPostReply> get serializer => _$mainPostReplySerializer;
}
