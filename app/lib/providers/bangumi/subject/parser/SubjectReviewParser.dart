import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/providers/bangumi/subject/parser/common.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';

class SubjectReviewParser {
  static const defaultPageNumber = 1;

  /// Bangumi displays 20 comments on each review page.
  static const maxReviewsPerPage = 20;

  final BuiltMap<String, MutedUser> mutedUsers;

  const SubjectReviewParser({
    @required this.mutedUsers,
  });

  ParsedSubjectReviews parseSubjectReviews(
    String rawHtml, {
    @required SubjectReviewMainFilter mainFilter,
    @required int requestedPageNumber,
  }) {
    DocumentFragment document = parseFragment(rawHtml);

    bool isValidReviewPage =
        document.querySelector('#memberUserList,#comment_box') != null;
    if (!isValidReviewPage) {
      throw BangumiResponseIncomprehensibleException();
    }

    int currentPageNumber = tryParseInt(
      document.querySelector('.p_cur')?.text?.trim(),
      defaultValue: null,
    );

    Optional<int> maybeMaxPageNumber =
    parseMaxPageNumber(document, currentPageNumber);

    LinkedHashMap<String, SubjectReview> reviews =
        new LinkedHashMap<String, SubjectReview>();

    // Requested page number must match current page number, other wise it's
    // invalid.
    bool hasMultiplePages = maybeMaxPageNumber.isNotEmpty;
    if (currentPageNumber != requestedPageNumber && hasMultiplePages) {
      return ParsedSubjectReviews(
        reviewItems: reviews,
        requestedPageNumber: requestedPageNumber,
        isRequestedPageNumberValid: false,
        maxPageNumber: maybeMaxPageNumber.value,
      );
    }

    int maxPageNumber =
        hasMultiplePages ? maybeMaxPageNumber.value : currentPageNumber;

    final subjectType = parseSubjectType(document);

    String commentsSelector;
    if (mainFilter == SubjectReviewMainFilter.WithNonEmptyComments) {
      commentsSelector = '#comment_box>.item';
    } else {
      assert(subjectType != null);
      commentsSelector = '#memberUserList > .user';
    }

    // Tracks all valid reviews, muted users are excluded from [reviews] so
    // [validReviews] should always >= [reviews.length]
    int validReviewsCount = 0;
    for (Element commentElement
        in document.querySelectorAll(commentsSelector)) {
      SubjectReview review;
      if (mainFilter == SubjectReviewMainFilter.WithNonEmptyComments) {
        review = parseSubjectReviewOnNonCollectionPage(
            commentElement, ReviewElement.CommentBox);
      } else {
        review = parseReviewOnCollectionPage(
          commentElement,
          subjectType: subjectType,
          collectionStatus: mainFilter.toCollectionStatus,
        );
      }

      validReviewsCount += 1;
      if (!mutedUsers.containsKey(review.metaInfo.username)) {
        reviews[review.metaInfo.username] = review;
      }
    }

    // Gets alert if bangumi changes [maxReviewsPerPage].
    assert(validReviewsCount <= maxReviewsPerPage);

    return ParsedSubjectReviews(
      reviewItems: reviews,
      requestedPageNumber: null,
      isRequestedPageNumberValid: true,
      maxPageNumber: maxPageNumber,
      canLoadMoreItems: validReviewsCount >= maxReviewsPerPage &&
          requestedPageNumber != maxPageNumber,
    );
  }
}

class ParsedSubjectReviews {
  /// Stores all reviews that have been parsed. key is [ItemMetaInfo.username].
  final LinkedHashMap<String, SubjectReview> reviewItems;

  /// Max page number as seen on bangumi.
  ///
  /// Note that bangumi might show 0 reviews on max page.
  final int maxPageNumber;

  /// Requested page number.
  final int requestedPageNumber;

  /// Whether the requested page number is valid, if it's invalid, bangumi
  /// redirects user to the first page.
  final bool isRequestedPageNumberValid;

  /// Whether parser can load more items.
  ///
  /// If there are fewer than [SubjectReviewParser.maxReviewsPerPage]
  /// reviews(but bigger than 1) on a page, it's considered the end of reviews.
  final bool canLoadMoreItems;

  const ParsedSubjectReviews({
    @required this.reviewItems,
    @required this.requestedPageNumber,
    @required this.isRequestedPageNumberValid,
    @required this.maxPageNumber,
    this.canLoadMoreItems,
  });

  @override
  String toString() {
    return 'ParsedSubjectReviews{'
        'reviews: $reviewItems, '
        'maxPageNumber: $maxPageNumber, '
        'requestedPageNumber: $requestedPageNumber, '
        'isRequestedPageNumberValid: $isRequestedPageNumberValid, '
        'canLoadMoreItems: $canLoadMoreItems}';
  }
}
