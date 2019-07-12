import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'GetSubjectReviewRequest.g.dart';

abstract class GetSubjectReviewRequest
    implements Built<GetSubjectReviewRequest, GetSubjectReviewRequestBuilder> {
  int get subjectId;

  SubjectReviewMainFilter get mainFilter;

  /// Whether to only show reviews from friends.
  ///
  /// Setting it to `false` shows reviews from all users.
  bool get showOnlyFriends;

  GetSubjectReviewRequest._();

  factory GetSubjectReviewRequest(
          [void Function(GetSubjectReviewRequestBuilder) updates]) =
      _$GetSubjectReviewRequest;

  String toJson() {
    return json.encode(
        serializers.serializeWith(GetSubjectReviewRequest.serializer, this));
  }

  static GetSubjectReviewRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        GetSubjectReviewRequest.serializer, json.decode(jsonString));
  }

  static Serializer<GetSubjectReviewRequest> get serializer =>
      _$getSubjectReviewRequestSerializer;
}
