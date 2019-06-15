import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectParser.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectReviewParser.dart';

BangumiSubject processBangumiSubject(ParseBangumiSubjectMessage message) {
  BangumiSubject subject =
      SubjectParser(mutedUsers: message.mutedUsers).process(message.html);

  return subject;
}

/// A request message that's sent through isolate to parse bangumi subject.
class ParseBangumiSubjectMessage {
  final String html;

  final BuiltMap<String, MutedUser> mutedUsers;

  const ParseBangumiSubjectMessage(this.html, this.mutedUsers);
}

ParsedSubjectReviews processBangumiSubjectReview(
    ParseBangumiSubjectReviewsMessage message) {
  ParsedSubjectReviews parsedSubjectReviews =
      SubjectReviewParser(mutedUsers: message.mutedUsers).parseSubjectReviews(
    message.html,
    mainFilter: message.mainFilter,
    requestedPageNumber: message.requestedPageNumber,
  );

  return parsedSubjectReviews;
}

/// A request message that's sent through isolate to parse bangumi subject review.
class ParseBangumiSubjectReviewsMessage {
  final String html;

  final BuiltMap<String, MutedUser> mutedUsers;

  final SubjectReviewMainFilter mainFilter;

  final int requestedPageNumber;

  final SubjectType subjectType;

  ParseBangumiSubjectReviewsMessage(
    this.html, {
    @required this.mutedUsers,
    @required this.mainFilter,
    @required this.requestedPageNumber,
    this.subjectType,
  });
}
