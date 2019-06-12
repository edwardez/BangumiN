import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'SubjectReviewMainFilter.g.dart';

/// A main filter for subject review.
///
/// As opposite, a sub-filter is the source of the review(only from friends, or
/// from all bangumi users).
class SubjectReviewMainFilter extends EnumClass {
  static const withNonEmptyCommentsChineseName = '短评';

  /// Filters with only reviews that have a comment.
  ///
  /// Bangumi disallows selecting [SubjectReviewSource] if [SubjectReviewMainFilter]
  /// is set to [SubjectReviewMainFilter.WithNonEmptyComments]
  static const SubjectReviewMainFilter WithNonEmptyComments =
      _$WithNonEmptyComments;

  /// Following filters are based on users' [CollectionStatus]

  static const SubjectReviewMainFilter FromWishedUsers = _$FromWishedUsers;

  static const SubjectReviewMainFilter FromCompletedUsers =
      _$FromCompletedUsers;

  static const SubjectReviewMainFilter FromInProgressUsers =
      _$FromInProgressUsers;

  static const SubjectReviewMainFilter FromOnHoldUsers = _$FromOnHoldUsers;

  static const SubjectReviewMainFilter FromDroppedUsers = _$FromDroppedUsers;

  String chineseName(SubjectType subjectType) {
    switch (this) {
      case SubjectReviewMainFilter.WithNonEmptyComments:
        return withNonEmptyCommentsChineseName;
      case SubjectReviewMainFilter.FromWishedUsers:
      case SubjectReviewMainFilter.FromCompletedUsers:
      case SubjectReviewMainFilter.FromInProgressUsers:
      case SubjectReviewMainFilter.FromOnHoldUsers:
      case SubjectReviewMainFilter.FromDroppedUsers:
        return CollectionStatus.chineseNameWithSubjectType(
            this.toCollectionStatus, subjectType);
      default:
        assert(false, '$this doesn\'t have a valid chinese name');
        return '-';
    }
  }

  CollectionStatus get toCollectionStatus {
    switch (this) {
      case SubjectReviewMainFilter.FromWishedUsers:
        return CollectionStatus.Wish;
      case SubjectReviewMainFilter.FromCompletedUsers:
        return CollectionStatus.Completed;
      case SubjectReviewMainFilter.FromInProgressUsers:
        return CollectionStatus.InProgress;
      case SubjectReviewMainFilter.FromOnHoldUsers:
        return CollectionStatus.OnHold;
      case SubjectReviewMainFilter.FromDroppedUsers:
        return CollectionStatus.Dropped;
      default:
        assert(false, '$this doesn\'t have a valid CollectionStatus');
        return CollectionStatus.Unknown;
    }
  }

  String get wiredNameOnWebPage {
    switch (this) {
      case SubjectReviewMainFilter.FromWishedUsers:
        return 'wishes';
      case SubjectReviewMainFilter.FromCompletedUsers:
        return 'collections';
      case SubjectReviewMainFilter.FromInProgressUsers:
        return 'doings';
      case SubjectReviewMainFilter.FromOnHoldUsers:
        return CollectionStatus.OnHold.wiredName;
      case SubjectReviewMainFilter.FromDroppedUsers:
        return CollectionStatus.Dropped.wiredName;
      default:
        assert(false, '$this doesn\'t have a valid CollectionStatus');
        return '';
    }
  }

  const SubjectReviewMainFilter._(String name) : super(name);

  static BuiltSet<SubjectReviewMainFilter> get values => _$values;

  static SubjectReviewMainFilter valueOf(String name) => _$valueOf(name);

  static Serializer<SubjectReviewMainFilter> get serializer =>
      _$subjectReviewMainFilterSerializer;

  static SubjectReviewMainFilter fromWiredName(String wiredName) {
    return serializers.deserializeWith(
        SubjectReviewMainFilter.serializer, wiredName);
  }
}
