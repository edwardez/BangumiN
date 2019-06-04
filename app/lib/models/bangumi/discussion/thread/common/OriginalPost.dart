import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'OriginalPost.g.dart';

/// OriginalPost post in a thread that's posted by the original author.
abstract class OriginalPost
    implements Post, Built<OriginalPost, OriginalPostBuilder> {
  @override
  String get sequentialName {
    return '#$mainSequentialNumber';
  }

  OriginalPost._();

  factory OriginalPost([void Function(OriginalPostBuilder) updates]) =
      _$OriginalPost;

  String toJson() {
    return json
        .encode(serializers.serializeWith(OriginalPost.serializer, this));
  }

  static OriginalPost fromJson(String jsonString) {
    return serializers.deserializeWith(
        OriginalPost.serializer, json.decode(jsonString));
  }

  static Serializer<OriginalPost> get serializer => _$originalPostSerializer;
}
