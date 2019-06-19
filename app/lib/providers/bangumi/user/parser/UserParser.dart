import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/common/SubjectBaseWithCover.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/user/Relationship.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/preview/CollectionsOnProfilePage.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTagLink.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTagPlainText.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceType.dart';
import 'package:munin/models/bangumi/user/timeline/TimelinePreview.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:quiver/strings.dart';

class UserParser {
  static final bangumiCollectionIdRegex = RegExp(r'anime|game|music|book|real');
  static const defaultSubjectName = '-';

  BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>>
  _parseCollectionPanelWithCover(Element collectionElement,
          LinkedHashMap<CollectionStatus, int> count) {
    /// Bangumi uses a fallback strategy to display collected subjects
    /// 1. If user has subjects under [CollectionStatus.Do], this category will be displayed
    /// Similar strategy follows
    /// That being said, the first non-empty status element can be any element
    /// i.e. if user has only dropped some anime but has never 'wished'/'InProgress'
    /// any animation, the dropped will be displayed as firstValidStatusElement
    Element firstNonEmptyStatusLabel =
        collectionElement.querySelector('.substatus');

    CollectionStatus firstNonEmptyStatus =
        CollectionStatus.guessCollectionStatusByChineseName(
            firstNonEmptyStatusLabel?.text);
    if (count.isEmpty ||
        firstNonEmptyStatusLabel?.parent == null ||
        firstNonEmptyStatus == CollectionStatus.Unknown) {
      return null;
    }

    BuiltList<SubjectBaseWithCover> subjectsUnderFirstNonEmptyStatus =
    BuiltList<SubjectBaseWithCover>();
    List<Element> subjectElements =
        firstNonEmptyStatusLabel.parent.querySelectorAll('li > a');
    for (Element subjectElement in subjectElements) {
      int subjectId = tryParseInt(parseHrefId(subjectElement, digitOnly: true),
          defaultValue: null);
      String subjectName =
          subjectElement.attributes['title'] ?? defaultSubjectName;
      String subjectCover =
          subjectElement.querySelector('img')?.attributes['src'];
      if (subjectCover == null) {
        subjectCover = bangumiTextOnlySubjectCover;
      } else {
        subjectCover = normalizeImageUrl(subjectCover);
      }

      if (subjectId == null) {
        debugPrint('Unexpected subject element ${subjectElement.outerHtml}');
        continue;
      }

      SubjectBaseWithCover subjectPreview = SubjectBaseWithCover((b) =>
      b
        ..cover.replace(BangumiImage.fromImageUrl(
            subjectCover, ImageSize.Small, ImageType.SubjectCover))
        ..id = subjectId
        ..name = subjectName);

      subjectsUnderFirstNonEmptyStatus = subjectsUnderFirstNonEmptyStatus
          .rebuild((b) => b.add(subjectPreview));
    }

    return BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>>(
        {firstNonEmptyStatus: subjectsUnderFirstNonEmptyStatus});
  }

  BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>>
  _parsePlainTextCollectionPanel(Element collectionElement,
          LinkedHashMap<CollectionStatus, int> count) {
    CollectionStatus firstNonEmptyStatus = count.keys.first;
    BuiltList<SubjectBaseWithCover> subjectsUnderFirstNonEmptyStatus =
    BuiltList<SubjectBaseWithCover>();

    bool hasSeenSeparatorElement = false;
    for (Element possibleSubjectElement
        in collectionElement.querySelectorAll('.collect > li')) {
      if (possibleSubjectElement.classes.contains('cat')) {
        /// All element under first category has been looped, we abort
        if (hasSeenSeparatorElement) {
          break;
        }
        hasSeenSeparatorElement = true;
      } else {
        Element subjectElement = possibleSubjectElement.querySelector('a');
        if (subjectElement == null) {
          debugPrint('Unexpected subject element ${subjectElement.outerHtml}');
          continue;
        }

        int subjectId = tryParseInt(
            parseHrefId(subjectElement, digitOnly: true),
            defaultValue: null);
        String subjectName =
            subjectElement.attributes['title'] ?? defaultSubjectName;

        if (subjectId == null) {
          debugPrint('Unexpected subject element ${subjectElement.outerHtml}');
          continue;
        }

        SubjectBaseWithCover subjectPreview = SubjectBaseWithCover((b) =>
        b
          ..cover.replace(
              BangumiImage.useSameImageUrlForAll(bangumiTextOnlySubjectCover))
          ..id = subjectId
          ..name = subjectName);

        subjectsUnderFirstNonEmptyStatus = subjectsUnderFirstNonEmptyStatus
            .rebuild((b) => b.add(subjectPreview));
      }
    }

    return BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>>(
        {firstNonEmptyStatus: subjectsUnderFirstNonEmptyStatus});
  }

  CollectionsOnProfilePage _parseCollectionPreview(Element collectionElement,
      SubjectType subjectType, bool onPlainTextPanel) {
    LinkedHashMap<CollectionStatus, int> count =
        LinkedHashMap<CollectionStatus, int>();

    List<Element> allListItems =
        collectionElement.querySelectorAll('.horizontalOptions li');

    for (Element li in allListItems) {
      CollectionStatus status =
          CollectionStatus.guessCollectionStatusByChineseName(li.text);
      if (!CollectionStatus.isInvalid(status)) {
        String countStr =
            firstCapturedStringOrNull(atLeastOneDigitGroupRegex, li.text);
        count[status] = tryParseInt(countStr);
      }
    }

    BuiltMap<CollectionStatus, BuiltList<SubjectBaseWithCover>> subjects;

    if (onPlainTextPanel) {
      subjects = _parsePlainTextCollectionPanel(collectionElement, count);
    } else {
      subjects = _parseCollectionPanelWithCover(collectionElement, count);
    }

    return CollectionsOnProfilePage((b) =>
    b
      ..subjectType = subjectType
      ..onPlainTextPanel = onPlainTextPanel
      ..collectionDistribution.replace(count)
      ..subjects.replace(subjects));
  }

  /// Parse bangumi html to get collection previews
  /// Collection is visited in the order set by the user
  /// If user has not collected any subjects, this method returns an empty [BuiltMap]
  BuiltMap<SubjectType, CollectionsOnProfilePage> _parseCollectionPreviews(
      DocumentFragment document) {
    BuiltMap<SubjectType, CollectionsOnProfilePage> collectionPreviews =
    BuiltMap<SubjectType, CollectionsOnProfilePage>();

    Element mainPanel = document.querySelector('#user_home');
    for (Element element in mainPanel.children) {
      Match idMatcher = bangumiCollectionIdRegex.firstMatch(element.id);
      if (idMatcher != null) {
        SubjectType subjectType =
        SubjectType.getTypeByHttpWiredName(idMatcher.group(0));
        collectionPreviews = collectionPreviews.rebuild((b) => b
          ..addAll({
            subjectType: _parseCollectionPreview(element, subjectType, false)
          }));
      }
    }

    Element sidePanel = document.querySelector('#sideLayout');
    for (Element element in sidePanel.children) {
      Match idMatcher = bangumiCollectionIdRegex.firstMatch(element.id);
      if (idMatcher != null) {
        SubjectType subjectType =
        SubjectType.getTypeByHttpWiredName(idMatcher.group(0));
        collectionPreviews = collectionPreviews.rebuild((b) => b
          ..addAll({
            subjectType: _parseCollectionPreview(element, subjectType, true)
          }));
      }
    }

    return collectionPreviews;
  }

  BuiltList<TimelinePreview> _parseTimelinePreviews(
      List<Element> timelineElements) {
    BuiltList<TimelinePreview> previews = BuiltList<TimelinePreview>();

    for (Element element in timelineElements) {
      int updatedAt = parseBangumiTime(element.querySelector('.time')?.text)
          ?.millisecondsSinceEpoch;
      String content = element.querySelector('.feed')?.text;
      if (isNotEmpty(content) && updatedAt != null) {
        TimelinePreview preview = TimelinePreview((b) => b
          ..userUpdatedAt = updatedAt
          ..content = content);
        previews = previews.rebuild((b) => b..add(preview));
      } else {
        debugPrint(
            'Received invalid timeline preview feed ${element.outerHtml}');
      }
    }
    return previews;
  }

  BuiltList<NetworkServiceTag> _parseNetworkServiceTags(
      List<Element> tagElements) {
    BuiltList<NetworkServiceTag> tags = BuiltList<NetworkServiceTag>();
    for (Element element in tagElements) {
      NetworkServiceType networkServiceType =
          NetworkServiceType.fromBangumiValue(
              element.querySelector('.service')?.text);
      Element contentElement = element.querySelector('.tip');
      Element linkElement = element.querySelector('a');
      bool isLink = linkElement != null;

      NetworkServiceTag tag;
      if (isLink) {
        tag = NetworkServiceTagLink((b) => b
          ..isLink = true
          ..type = networkServiceType
          ..link = linkElement.attributes['href']
          ..content = linkElement.text.trim());
      } else {
        if (contentElement == null) {
          debugPrint('Received unknown network tag ${element.outerHtml}');
          continue;
        }

        tag = NetworkServiceTagPlainText((b) => b
          ..isLink = false
          ..type = networkServiceType
          ..content = contentElement.text.trim());
      }

      tags = tags.rebuild((b) => b..add(tag));
    }
    return tags;
  }

  UserProfile processUserProfile(String rawHtml) {
    DocumentFragment document = parseFragment(rawHtml);

    Element introductionElement =
        document.querySelector('blockquote.intro>div') ?? Element.tag('div');

    Set<Relationship> relationships = {};
    String relationShipText =
        document.querySelector('#friend_flag')?.text ?? '';

    /// Bangumi displays '是我的好友' no matter target user is following back current
    /// user or not. So only [Relationship.Following] can be added here
    if (relationShipText.contains('是我的好友')) {
      relationships.add(Relationship.Following);
    } else {
      relationships.add(Relationship.None);
    }

    BuiltMap<SubjectType, CollectionsOnProfilePage> previews =
    _parseCollectionPreviews(document);

    BuiltList<NetworkServiceTag> networkServiceTags = _parseNetworkServiceTags(
        document.querySelectorAll('.network_service > li'));

    BuiltList<TimelinePreview> timelinePreviews =
    _parseTimelinePreviews(document.querySelectorAll('.timeline > li'));

    return UserProfile((b) => b
      ..introductionInHtml = introductionElement.outerHtml
      ..introductionInPlainText = introductionElement.text
      ..relationships.replace(relationships)
      ..collectionPreviews.replace(previews)
      ..timelinePreviews.replace(timelinePreviews)
      ..networkServiceTags.replace(networkServiceTags));
  }
}
