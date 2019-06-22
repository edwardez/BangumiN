import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/user/collection/full/CollectionOnUserList.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/models/bangumi/user/collection/full/SubjectOnUserCollectionList.dart';
import 'package:munin/models/bangumi/user/collection/full/UserCollectionTag.dart';
import 'package:munin/providers/bangumi/util/parser/pagination.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';

class UserCollectionsListParser {
  /// Prefix for tags of a subject.
  final subjectTagsPrefixRegex = RegExp(r'\s*标签:\s*');
  final tagsSplitterRegex = RegExp(r'\s+');

  final ListUserCollectionsRequest request;

  UserCollectionsListParser({
    @required this.request,
  });

  CollectionOnUserList _parseCollectionOnUserList(Element collectionElement) {
    final coverImageUrl =
        imageSrcOrFallback(collectionElement.querySelector('img.cover'));

    final cover = BangumiImage.fromImageUrl(
      coverImageUrl,
      ImageSize.Unknown,
      ImageType.SubjectCover,
    );

    final subjectId = tryParseInt(
        parseHrefId(collectionElement.querySelector('a[href*="/subject/"]')),
        defaultValue: null);

    // If subject has a chinese name, [originalNameOrNull] is original name.
    // Otherwise it's null.
    final originalNameOrNull =
        collectionElement.querySelector('.inner .grey')?.text?.trim();

    // If subject has a chinese name, [maybeOriginalOrChineseName] is chinese name.
    // Otherwise it's original name.
    final chineseIfPresentOrOriginal = collectionElement
            .querySelector('.inner a[href*="/subject/"]')
            ?.text
            ?.trim() ??
        '';

    final additionalSubjectInfo =
        collectionElement.querySelector('.inner > .info.tip')?.text?.trim() ??
            '';

    final subject = SubjectOnUserCollectionList(
      (b) => b
        ..name = originalNameOrNull == null
            ? chineseIfPresentOrOriginal
            : originalNameOrNull
        ..chineseName =
            originalNameOrNull == null ? null : chineseIfPresentOrOriginal
        ..id = subjectId
        ..cover.replace(cover)
        ..additionalInfo = additionalSubjectInfo
        ..type = request.subjectType,
    );

    int rating = parseSubjectScore(collectionElement)?.toInt();

    DateTime collectionTime = parseDateTime(
        '${collectionElement.querySelector('.tip_j')?.text?.trim()} 00:00');

    final collectedByCurrentAppUser = collectionElement
            .querySelector('.collectBlock')
            ?.text
            ?.contains('删除') ??
        false;

    final comment =
        collectionElement.querySelector('#comment_box .text')?.text?.trim();

    List<String> tags = [];

    String rawTags = collectionElement
        .querySelectorAll('.collectInfo .tip')
        .firstWhere(
          (element) => element.text.contains('标签'),
          orElse: () => null,
        )
        ?.text
        ?.trim();

    if (rawTags != null) {
      rawTags = rawTags.replaceAll(subjectTagsPrefixRegex, '');
      tags = rawTags.split(tagsSplitterRegex);
    }

    return CollectionOnUserList((b) => b
      ..collectionStatus = request.collectionStatus
      ..subject.replace(subject)
      ..rating = rating
      ..collectedByCurrentAppUser = collectedByCurrentAppUser
      ..comment = comment
      ..tags.replace(BuiltList<String>.of(tags))
      ..collectedTimeMilliSeconds = collectionTime.millisecondsSinceEpoch);
  }

  LinkedHashMap<int, CollectionOnUserList> _parseCollections(
      DocumentFragment document) {
    LinkedHashMap<int, CollectionOnUserList> collections =
        LinkedHashMap<int, CollectionOnUserList>();

    for (var element in document.querySelectorAll('#browserItemList > li')) {
      final collection = _parseCollectionOnUserList(element);
      collections[collection.subject.id] = collection;
    }

    return collections;
  }

  Optional<UserCollectionTag> _parseUserCollectionTag(Element tagElement) {
    final tagCountElement = tagElement.querySelector('small');
    final count = tryParseInt(
      tagCountElement?.text?.trim(),
      defaultValue: null,
    );
    final name = nextNodeSibling(tagCountElement)?.text;

    if (name == null || count == null) {
      return Optional.absent();
    }

    return Optional.of(UserCollectionTag((b) => b
      ..name = name
      ..taggedSubjectsCount = count));
  }

  LinkedHashMap<String, UserCollectionTag> _parseUserCollectionTags(
      DocumentFragment document) {
    final tags = LinkedHashMap<String, UserCollectionTag>();

    for (var tagElement in document.querySelectorAll('#userTagList > li')) {
      final maybeTag = _parseUserCollectionTag(tagElement);
      if (maybeTag.isPresent) {
        tags[maybeTag.value.name] = maybeTag.value;
      }
    }

    return tags;
  }

  ParsedCollections processUserCollectionsList(
    String rawHtml, {
    @required int requestedPageNumber,
  }) {
    DocumentFragment document = parseFragment(rawHtml);

    final parsedPaginationElement = parsePaginationElement(
      document,
      requestedPageNumber,
    );

    final maybeMaxPageNumber = parsedPaginationElement.maybeMaxPageNumber;
    final currentPageNumber =
        parsedPaginationElement.maybeCurrentPageNumber.orNull;
    bool isRequestedPageNumberValid =
        parsedPaginationElement.isRequestedPageNumberValid;
    if (!isRequestedPageNumberValid) {
      return ParsedCollections(
        maxPageNumber: maybeMaxPageNumber.orNull,
        isRequestedPageNumberValid: false,
        collections: LinkedHashMap(),
        tags: LinkedHashMap(),
        requestedPageNumber: requestedPageNumber,
      );
    }

    bool hasMultiplePages = maybeMaxPageNumber.isPresent;

    int maxPageNumber =
        hasMultiplePages ? maybeMaxPageNumber.value : currentPageNumber;

    final collections = _parseCollections(document);

    final tags = _parseUserCollectionTags(document);

    bool canLoadMoreItems = true;
    if (!hasMultiplePages) {
      canLoadMoreItems = false;
    } else if (hasMultiplePages && maxPageNumber == currentPageNumber) {
      canLoadMoreItems = false;
    }

    return ParsedCollections(
        maxPageNumber: maxPageNumber,
        isRequestedPageNumberValid: true,
        collections: collections,
        tags: tags,
        requestedPageNumber: requestedPageNumber,
        canLoadMoreItems: canLoadMoreItems);
  }
}

class ParsedCollections {
  /// Stores all collections that are parsed from current page.
  /// Key is subject id.
  final LinkedHashMap<int, CollectionOnUserList> collections;

  /// Map of available tags, key is tag name.
  final LinkedHashMap<String, UserCollectionTag> tags;

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

  const ParsedCollections({
    @required this.collections,
    @required this.tags,
    @required this.requestedPageNumber,
    @required this.isRequestedPageNumberValid,
    @required this.maxPageNumber,
    this.canLoadMoreItems,
  });

  @override
  String toString() {
    return 'ParsedCollections{'
        'collections: $collections, '
        'tags: $tags, '
        'maxPageNumber: $maxPageNumber, '
        'requestedPageNumber: $requestedPageNumber, '
        'isRequestedPageNumberValid: $isRequestedPageNumberValid, '
        'canLoadMoreItems: $canLoadMoreItems}';
  }
}
