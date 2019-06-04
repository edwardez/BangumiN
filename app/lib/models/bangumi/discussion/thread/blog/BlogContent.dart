import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadParentSubject.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'BlogContent.g.dart';

abstract class BlogContent implements Built<BlogContent, BlogContentBuilder> {
  BangumiUserBasic get author;

  /// Blog content in html.
  String get html;

  /// Post epoch time in milli seconds.
  int get postTimeInMilliSeconds;

  /// A blog can be associated with multiple subjects by user.
  /// [associatedSubjects] stores list of associated subjects.
  BuiltList<ThreadParentSubject> get associatedSubjects;

  BlogContent._();

  factory BlogContent([void Function(BlogContentBuilder) updates]) =
      _$BlogContent;

  String toJson() {
    return json.encode(serializers.serializeWith(BlogContent.serializer, this));
  }

  static BlogContent fromJson(String jsonString) {
    return serializers.deserializeWith(
        BlogContent.serializer, json.decode(jsonString));
  }

  static Serializer<BlogContent> get serializer => _$blogContentSerializer;
}
