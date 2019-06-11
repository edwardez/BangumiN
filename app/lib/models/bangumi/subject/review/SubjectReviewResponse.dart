import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/common/ItemMetaInfo.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectReviewResponse.g.dart';

abstract class SubjectReviewResponse
    implements Built<SubjectReviewResponse, SubjectReviewResponseBuilder> {
  /// Page number that indicates Munin has requested until which page on bangumi.
  ///
  /// For example, there are 5 pages of reviews, for a subject munin has requested
  /// page 1 and page 2 in newest first order, then [requestedUntilPageNumber] is 2.
  ///
  /// For newest first order, [requestedUntilPageNumber] starts from the first page
  /// then increases.
  /// For reverse order, [requestedUntilPageNumber] starts from the last page
  /// then decreases.
  int get requestedUntilPageNumber;

  /// Last valid page on bangumi that has reviews.
  ///
  /// While bangumi gives a last page number, this value doesn't always works.
  /// For example: https://bgm.tv/subject/253/collections?page=326
  /// bangumi returns a page with empty reviews.
  /// Maybe bangumi filters some reviews but forgot to adjust the review count
  /// accordingly.
  @nullable
  int get lastValidBangumiPageNumber;

  /// Whether munin can load more items and has not reached the end.
  bool get canLoadMoreItems;

  /// Stores all reviews that have been retrieved. key is [ItemMetaInfo.username].
  BuiltMap<String, SubjectReview> get items;

  SubjectReviewResponse._();

  factory SubjectReviewResponse(
          [void Function(SubjectReviewResponseBuilder) updates]) =
      _$SubjectReviewResponse;

  String toJson() {
    return json.encode(
        serializers.serializeWith(SubjectReviewResponse.serializer, this));
  }

  static SubjectReviewResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        SubjectReviewResponse.serializer, json.decode(jsonString));
  }

  static Serializer<SubjectReviewResponse> get serializer =>
      _$subjectReviewResponseSerializer;
}
