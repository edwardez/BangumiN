import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectCommentMetaInfo.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectComment.g.dart';

abstract class SubjectComment
    implements Built<SubjectComment, SubjectCommentBuilder> {
  SubjectComment._();

  factory SubjectComment([updates(SubjectCommentBuilder b)]) = _$SubjectComment;

  SubjectCommentMetaInfo get metaInfo;

  String get content;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectComment.serializer, this));
  }

  static SubjectComment fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectComment.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectComment> get serializer =>
      _$subjectCommentSerializer;
}
