import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/comment/ReviewMetaInfo.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectReview.g.dart';

abstract class SubjectReview
    implements Built<SubjectReview, SubjectReviewBuilder> {
  SubjectReview._();

  factory SubjectReview([updates(SubjectReviewBuilder b)]) = _$SubjectReview;

  ReviewMetaInfo get metaInfo;

  String get content;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SubjectReview.serializer, this));
  }

  static SubjectReview fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectReview.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectReview> get serializer => _$subjectReviewSerializer;
}
