import 'dart:core';
import 'dart:math' as math;

import 'package:html/dom.dart' show DocumentFragment, Element, Node, NodeList;
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';

final _pageNumberRegex = RegExp(r'\?page=(\d+)');

/// Parses a common pagination element on bangumi.
ParsedPaginationElement parsePaginationElement(
    DocumentFragment document, int requestedPageNumber) {
  Optional<int> maybeCurrentPageNumber = _parseCurrentPageNumber(document);

  Optional<int> maybeMaxPageNumber =
      _parseMaxPageNumber(document, maybeCurrentPageNumber.orNull);

  bool hasOnlyOnePage = maybeMaxPageNumber.isNotPresent;

  // Requested page number must match current page number, other wise it's
  // invalid.
  // Only one exception: if it has only one page, then ParsedPaginationElement
  // might not exist.
  bool isRequestedPageNumberValid =
      maybeCurrentPageNumber.orNull == requestedPageNumber || hasOnlyOnePage;

  return ParsedPaginationElement(
    maybeMaxPageNumber,
    maybeCurrentPageNumber,
    isRequestedPageNumberValid,
  );
}

class ParsedPaginationElement {
  final Optional<int> maybeMaxPageNumber;
  final Optional<int> maybeCurrentPageNumber;
  final bool isRequestedPageNumberValid;

  const ParsedPaginationElement(
    this.maybeMaxPageNumber,
    this.maybeCurrentPageNumber,
    this.isRequestedPageNumberValid,
  );
}

Optional<int> _parseCurrentPageNumber(DocumentFragment document) {
  int pageNumber = tryParseInt(
    document.querySelector('.p_cur')?.text?.trim(),
    defaultValue: null,
  );
  if (pageNumber == null) {
    return Optional.absent();
  }

  return Optional.of(pageNumber);
}

/// Parses and returns an optional max page number by reading pagination elements.
///
/// Returning [Optional.absent()] indicates that max page number cannot be
/// found. Most likely it's because there is only one page and pagination
/// element doesn't exist.
Optional<int> _parseMaxPageNumber(
    DocumentFragment document, int currentPageNumber) {
  const defaultPageNumber = 1;
  currentPageNumber ??= defaultPageNumber;

  final paginationElements = document.querySelectorAll('a.p[href*="?page="]');
  if (paginationElements.isEmpty) {
    return Optional.absent();
  }

  // element with max pagination number must be one of the last two elements.
  int startIndex = math.max(paginationElements.length - 2, 0);
  final possibleMaxPaginationElements =
      paginationElements.sublist(startIndex, paginationElements.length);

  int maxPageNumber = defaultPageNumber;

  for (var element in possibleMaxPaginationElements) {
    int pageNumberInLink = tryParseInt(
        firstCapturedStringOrNull(_pageNumberRegex, element.attributes['href']),
        defaultValue: defaultPageNumber);

    maxPageNumber = math.max(maxPageNumber, pageNumberInLink);
  }

  maxPageNumber = math.max(maxPageNumber, currentPageNumber);

  return Optional.of(maxPageNumber);
}
