import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/mono/Actor.dart';
import 'package:munin/models/bangumi/mono/Character.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/CollectionStatusDistribution.dart';
import 'package:munin/models/bangumi/subject/Count.dart';
import 'package:munin/models/bangumi/subject/Rating.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/bangumi/subject/SubjectCollectionInfoPreview.dart';
import 'package:munin/models/bangumi/subject/common/SubjectStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/subject/info/InfoBoxItem.dart';
import 'package:munin/models/bangumi/subject/info/InfoBoxRow.dart';
import 'package:munin/models/bangumi/subject/progress/SubjectProgressPreview.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/providers/bangumi/subject/parser/common.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/strings.dart';

class SubjectParser {
  static const curatedRowMappings = {
    SubjectType.Anime: {
      '话数',
      '动画制作',
      '原作',
      '制作',
      '监督',
      '放送开始',
      '发售日',
      '发售日期',
      '上映年度'
    },
    SubjectType.Game: {
      '开发',
      '制作',
      '平台',
      '发行日期',
    },
    SubjectType.Music: {
      '艺术家',
      '厂牌',
      '发售日期',
    },
    SubjectType.Book: {
      '作者',
      '插图',
      '原作',
      '作画',
      '开始',
      '结束',
      '发售日',
      '话数',
      '册数',
      '连载杂志',
      '文库',
    },
    SubjectType.Real: {
      '国家/地区',
      '类型',
      '开始',
      '结束',
    },
  };

  final BuiltMap<String, MutedUser> mutedUsers;

  const SubjectParser({@required this.mutedUsers});

  /// parse a InfoBoxItem, returns null if node is unexpected or invalid
  /// if a element has a link, we assume it's a link to a person
  /// Note: this function will return without filtering even if
  /// text node is a separator like  '、'. The reason is it's not easy to distinguish
  /// separator from actual infoBoxName
  InfoBoxItem parseInfoBoxItem(Node node) {
    InfoBoxItem infoBoxItem;
    if (node.nodeType == Node.ELEMENT_NODE) {
      Element element = node as Element;

      /// if an element contain tip class or it doesn't have class(unexpected)
      /// skip it
      if (element.classes?.contains('tip') ?? false) {
        return null;
      }

      /// currently, if a infobox item has a link, it must be a person
      /// this behaviour seems to be stable in past years so for performance reason
      /// we don't check whether the link is
      infoBoxItem = InfoBoxItem((b) => b
        ..type = BangumiContent.Person
        ..id = parseHrefId(element, digitOnly: true)
        ..name = node.text);
    } else if (node.nodeType == Node.TEXT_NODE) {
      infoBoxItem = InfoBoxItem((b) => b
        ..type = BangumiContent.PlainText
        ..name = node.text);
    }

    return infoBoxItem;
  }

  List<InfoBoxItem> parseInfoBoxRow(
      Element infoBoxRowElement, SubjectType subjectType) {
    List<InfoBoxItem> infoBoxItems = [];
    for (Node node in infoBoxRowElement.nodes) {
      InfoBoxItem infoBoxItem = parseInfoBoxItem(node);

      if (infoBoxItem != null) {
        infoBoxItems.add(infoBoxItem);
      }
    }

    return infoBoxItems;
  }

  Rating parseRating(Element ratingElement) {
    List<int> scoreArray = [];
    int totalVotesCount = 0;
    ratingElement.querySelectorAll('.horizontalChart li').forEach((element) {
      int scoreVotesCount = tryParseInt(element
          .querySelector('.count')
          ?.text
          ?.replaceAll(RegExp(r'\(|\)'), ''));
      totalVotesCount += scoreVotesCount;
      scoreArray.add(scoreVotesCount);
    });

    Count count = Count.fromDescendingScoreArray(scoreArray);
    double score = tryParseDouble(
        ratingElement.querySelector('[property="v:average"]')?.text);

    Element friendScoreElement = ratingElement.querySelector('.frdScore');
    int friendScoreVotesCount = extractFirstIntGroup(
        friendScoreElement?.querySelector('a')?.text,
        defaultValue: 0);

    double friendScore = tryParseDouble(
        friendScoreElement?.querySelector('.num')?.text,
        defaultValue: null);

    return Rating((b) => b
      ..score = score
      ..count.replace(count)
      ..totalScoreVotesCount = totalVotesCount
      ..friendScore = friendScore
      ..friendScoreVotesCount = friendScoreVotesCount);
  }

  SubjectCollectionInfoPreview parseSubjectCollectionInfoPreview(
    Element collectionStatusElement,
    Element scoreElement,
  ) {
    int score = scoreElement == null
        ? 0
        : tryParseInt(scoreElement.attributes['value']);

    CollectionStatus status =
        CollectionStatus.guessCollectionStatusByChineseName(
            collectionStatusElement.querySelector('.interest_now')?.text,
            fallbackCollectionStatus: CollectionStatus.Pristine);

    return SubjectCollectionInfoPreview((b) => b
      ..score = score
      ..status = status);
  }

  BuiltList<Actor> parseActors(Element characterElement) {
    List<Actor> actors = [];
    List<Element> actorElements =
        characterElement.querySelectorAll('a[rel=\"v:starring\"]');

    for (Element actorElement in actorElements) {
      int actorId = tryParseInt(parseHrefId(actorElement, digitOnly: true),
          defaultValue: null);
      String actorName = actorElement.text ?? '';
      actors.add(Actor((b) => b
        ..name = actorName
        ..id = actorId));
    }

    return BuiltList<Actor>(actors);
  }

  BuiltList<SubjectReview> parseReviews(DocumentFragment subjectElement) {
    /// a [SplayTreeSet] that contains a sorted set of reviews where
    /// where comparator is the review time([ReviewMetaInfo.updatedAt]) and
    /// sorted in descending order
    SplayTreeSet<SubjectReview> reviews = SplayTreeSet<SubjectReview>(
        (SubjectReview reviewA, SubjectReview reviewB) {
      /// If username is the same, always skipping insertion
      if (reviewA.metaInfo.username == reviewB.metaInfo.username) {
        return 0;
      }

      int reviewAUpdatedAt = reviewA.metaInfo.updatedAt ?? 0;
      int reviewBUpdatedAt = reviewB.metaInfo.updatedAt ?? 0;
      if (reviewAUpdatedAt != reviewBUpdatedAt) {
        return reviewBUpdatedAt - reviewAUpdatedAt;
      }

      /// If [UpdatedAt] is the same, we sort by username
      return reviewB.metaInfo.username.compareTo(reviewA.metaInfo.username);
    });

    List<Element> commentBoxElements =
        subjectElement.querySelectorAll('#comment_box>.item');

    /// Elements that are in the comment box
    for (Element commentElement in commentBoxElements) {
      SubjectReview review = parseSubjectReviewOnNonCollectionPage(
          commentElement, ReviewElement.CommentBox);
      if (!mutedUsers.containsKey(review.metaInfo.username)) {
        reviews.add(review);
      }
    }

    List<Element> recentCollectionElements = subjectElement
        .querySelectorAll('#subjectPanelCollect > .groupsLine > li');
    for (Element recentCollectionElement in recentCollectionElements) {
      SubjectReview review = parseSubjectReviewOnNonCollectionPage(
          recentCollectionElement, ReviewElement.CollectionPreview);
      if (!mutedUsers.containsKey(review.metaInfo.username)) {
        reviews.add(review);
      }
    }

    return BuiltList<SubjectReview>(reviews);
  }

  BuiltList<Character> parseCharacters(DocumentFragment subjectElement) {
    List<Character> characters = [];

    List<Element> characterElements =
        subjectElement.querySelectorAll('.subject_section .user');

    for (Element characterElement in characterElements) {
      Element avatarElement = characterElement.querySelector('a.avatar');
      int characterId = tryParseInt(parseHrefId(avatarElement, digitOnly: true),
          defaultValue: null);
      String characterName = avatarElement?.text?.trim() ?? '';
      String roleName =
          characterElement.querySelector('.badge_job_tip')?.text ?? '';

      String characterImageSmall = imageUrlFromBackgroundImage(avatarElement);
      BangumiImage avatar = BangumiImage.fromImageUrl(
          characterImageSmall, ImageSize.Unknown, ImageType.MonoAvatar);

      String collectionCountsStr =
          characterElement.querySelector('.fade.rr')?.text ?? '0';
      int collectionCounts = extractFirstIntGroup(collectionCountsStr);
      BuiltList<Actor> actors = parseActors(characterElement);

      Character character = Character((b) => b
        ..id = characterId
        ..name = characterName
        ..roleName = roleName
        ..avatar.replace(avatar)
        ..collectionCounts = collectionCounts
        ..actors.replace(actors));
      characters.add(character);
    }

    return BuiltList<Character>(characters);
  }

  BuiltListMultimap<String, RelatedSubject> _parseRelatedSubjects(
      DocumentFragment subjectElement, SubjectType subjectType) {
    ListMultimap<String, RelatedSubject> relatedSubjects =
        ListMultimap<String, RelatedSubject>();
    List<Element> relatedSubjectElements =
        subjectElement.querySelectorAll('.browserCoverMedium > li');

    String lastValidSubjectSubType = '';

    /// parse 关联条目
    for (Element subjectElement in relatedSubjectElements) {
      String subjectSubType =
          subjectElement.querySelector('.sub')?.text?.trim();

      /// bangumi will not set subject type if current subject has the same
      /// subject type as previous ones, hence we need to store and use the
      /// [lastValidSubjectSubType], see https://imgur.com/a/jji4YaF
      if (isEmpty(subjectSubType)) {
        /// subjectSubType might be null, last valid subject sub type is used
        subjectSubType = lastValidSubjectSubType;
      } else {
        /// if subjectSubType is not null, set is as last valid subject sub type
        lastValidSubjectSubType = subjectSubType;
      }

      Element subjectTitleElement = subjectElement.querySelector('a.title');
      String subjectName = subjectTitleElement?.text?.trim() ?? '';
      int subjectId = tryParseInt(
          parseHrefId(subjectTitleElement, digitOnly: true),
          defaultValue: null);

      Element coverElement = subjectElement.querySelector('a.avatar');
      String subjectNameCn;
      BangumiImage cover;

      if (coverElement != null) {
        subjectNameCn = coverElement.attributes['data-original-title'] ??
            coverElement.attributes['title'];
        String coverImage = imageUrlFromBackgroundImage(coverElement);
        coverImage ??= BangumiImage.defaultCoverImage;
        cover = BangumiImage.fromImageUrl(
            coverImage, ImageSize.Unknown, ImageType.SubjectCover);
      }

      RelatedSubject relatedSubject = RelatedSubject((b) => b
        ..name = subjectName
        ..chineseName = subjectNameCn
        ..id = subjectId
        ..cover.replace(cover)
        ..subjectSubTypeName = subjectSubType);

      relatedSubjects.add(subjectSubType, relatedSubject);
    }

    if (subjectType != SubjectType.Book) {
      return BuiltListMultimap<String, RelatedSubject>(relatedSubjects);
    }



    return BuiltListMultimap<String, RelatedSubject>(relatedSubjects);
  }

  BuiltList<RelatedSubject> _parseTankobonSubjects(
      DocumentFragment subjectElement, SubjectType subjectType) {
    if (subjectType != SubjectType.Book) {
      return BuiltList<RelatedSubject>();
    }
    List<RelatedSubject> relatedSubjects = [];

    /// it's possible book is associated with 单行本(tankobon), which is only
    /// valid for book
    List<Element> tankobonElements =
    subjectElement.querySelectorAll('.browserCoverSmall > li');

    for (Element tankobonElement in tankobonElements) {
      Element coverElement = tankobonElement.querySelector('a.avatar');

      /// coverElement should not be null, if it is, it's unexpected so we
      /// silently continue
      if (coverElement == null) {
        continue;
      }

      int subjectId = tryParseInt(parseHrefId(coverElement, digitOnly: true),
          defaultValue: null);

      /// subject original name is stored in `title` in plain html
      /// and seems like bangumi js sets attribute `title` to `data-original-title`
      /// after execution
      /// Name is stored in something like [original name] / [chinese name], separated
      /// by slash, however considering even original title itself might contains
      /// slash sign, it's better to parse subject name conservatively(instead of splitting
      /// subject name by slash and guessing original/chinese name )
      String subjectName = coverElement.attributes['data-original-title'] ??
          coverElement.attributes['title'] ??
          '';

      String coverImage = imageUrlFromBackgroundImage(coverElement);
      coverImage ??= BangumiImage.defaultCoverImage;
      BangumiImage cover = BangumiImage.fromImageUrl(
          coverImage, ImageSize.Unknown, ImageType.SubjectCover);

      RelatedSubject relatedSubject = RelatedSubject((b) =>
      b
        ..name = subjectName
        ..id = subjectId
        ..cover.replace(cover)
        ..subjectSubTypeName = '单行本');

      relatedSubjects.add(relatedSubject);
    }
    return BuiltList<RelatedSubject>.of(relatedSubjects);
  }

  InfoBoxRow parseSubjectSubtype(DocumentFragment subjectElement) {
    final subtypeElements =
        subjectElement.querySelectorAll('.nameSingle > .grey');
    String subTypeName = '';
    for (Element element in subtypeElements) {
      subTypeName += element?.text?.trim() ?? '';
    }

    if (isEmpty(subTypeName)) {
      return null;
    }

    InfoBoxItem infoBoxItem = InfoBoxItem((b) => b
      ..name = subTypeName
      ..type = BangumiContent.PlainText);
    InfoBoxRow infoBoxRow = InfoBoxRow((b) => b
      ..rowName = '类型'
      ..isCuratedRow = true
      ..rowItems.replace(BuiltList<InfoBoxItem>([infoBoxItem])));

    return infoBoxRow;
  }

  BuiltList<String> parseBangumiSuggestedTags(DocumentFragment subjectElement) {
    List<String> tags = [];

    List<Element> tagElements = subjectElement.querySelectorAll('.tagList a');
    RegExp invalidChars = RegExp(',| +');
    for (Element element in tagElements) {
      if (!isEmpty(element.text)) {
        tags.add(element.text.replaceAll(invalidChars, ''));
      }
    }

    return BuiltList<String>(tags);
  }

  BuiltList<String> parseUserSelectedTags(DocumentFragment subjectElement) {
    List<String> userTags = [];

    Element tagElement = subjectElement.querySelector('#tags');
    RegExp invalidChars = RegExp(',| +');
    if (tagElement != null) {
      String concatenatedTags = tagElement.attributes['value'] ?? '';
      List<String> splitTags = concatenatedTags.split(' ');
      for (String tag in splitTags) {
        tag = tag.replaceAll(invalidChars, '');
        if (!isEmpty(tag)) {
          userTags.add(tag);
        }
      }
    }

    return BuiltList<String>(userTags);
  }

  CollectionStatusDistribution parserCollectionStatusDistribution(
      Element infoElement) {
    int parseCount(SubjectReviewMainFilter collectionType) {
      final element = infoElement?.querySelector(
          'a[href^="/subject"][href\$="${collectionType.wiredNameOnWebPage}"]');

      int count = 0;

      if (element == null || infoElement == null) {
        return count;
      }

      count = tryParseInt(
          firstCapturedStringOrNull(atLeastOneDigitGroupRegex, element.text),
          defaultValue: 0);

      return count;
    }

    return CollectionStatusDistribution(
      (b) => b
        ..wish = parseCount(SubjectReviewMainFilter.FromWishedUsers)
        ..completed = parseCount(SubjectReviewMainFilter.FromCompletedUsers)
        ..inProgress = parseCount(SubjectReviewMainFilter.FromInProgressUsers)
        ..onHold = parseCount(SubjectReviewMainFilter.FromOnHoldUsers)
        ..dropped = parseCount(SubjectReviewMainFilter.FromDroppedUsers),
    );
  }

  /// Parses BookProgress, or returns an empty [SubjectProgressPreview] if such
  /// info is not available on html.
  SubjectProgressPreview parseSubjectProgressPreview(
    DocumentFragment document,
    SubjectType subjectType,
  ) {
    final progressElement = document.querySelector('.panelProgress');
    if (progressElement == null) {
      return SubjectProgressPreview();
    }

    final completedEpisodesElement =
        progressElement.querySelector('#watchedeps');

    final completedEpisodesCount = tryParseInt(
        attributesValueOrNull(completedEpisodesElement, 'value'),
        defaultValue: null);
    final totalEpisodesCount = tryParseInt(
        firstCapturedStringOrNull(atLeastOneDigitGroupRegex,
            nextNodeSibling(completedEpisodesElement)?.text ?? ''),
        defaultValue: null);

    final completedVolumesElement =
        progressElement.querySelector('#watched_vols');
    final completedVolumesCount = tryParseInt(
        attributesValueOrNull(completedVolumesElement, 'value'),
        defaultValue: null);
    final totalVolumesCount = tryParseInt(
        firstCapturedStringOrNull(atLeastOneDigitGroupRegex,
            nextNodeSibling(completedVolumesElement)?.text ?? ''),
        defaultValue: null);

    bool isTankobon;
    if (subjectType == SubjectType.Book) {
      String subjectSubTypeText =
          document.querySelector('.nameSingle')?.text?.trim() ?? '';
      if (subjectSubTypeText.endsWith('系列')) {
        isTankobon = true;
      } else {
        isTankobon = false;
      }
    }

    return SubjectProgressPreview((b) => b
      ..completedEpisodesCount = completedEpisodesCount
      ..completedVolumesCount = completedVolumesCount
      ..totalEpisodesCount = totalEpisodesCount
      ..totalVolumesCount = totalVolumesCount
      ..isTankobon = isTankobon);
  }

  /// In-place updates [infoBoxRows] with [infoBoxItems]
  /// add a separator to value of infoBoxRows if it's not empty
  _addSeparatorIfNotFirstInfoBoxItem(
      ListMultimap<String, InfoBoxItem> infoBoxRows,
      String newInfoBoxRowName,
      Iterable<InfoBoxItem> infoBoxItems) {
    if (infoBoxRows.containsKey(newInfoBoxRowName)) {
      infoBoxRows.add(newInfoBoxRowName, InfoBoxRow.separator);
    }
    infoBoxRows.addValues(newInfoBoxRowName, infoBoxItems);
  }

  SubjectStatus _parseSubjectStatus(DocumentFragment document) {
    final containsLockedKeyWord = document
        .querySelector('#headerSubject')
        ?.text
        ?.contains('条目已锁定') ?? false;
    var subjectStatus;
    if (containsLockedKeyWord) {
      subjectStatus = SubjectStatus.LockedForCollection;
    } else {
      subjectStatus = SubjectStatus.Normal;
    }

    return subjectStatus;
  }

  BangumiSubject process(String rawHtml) {
    DocumentFragment document = parseFragment(rawHtml);
    final subjectType = parseSubjectType(document);

    final subjectStatus = _parseSubjectStatus(document);

    final nameElement = document.querySelector('.nameSingle > a');
    String name;
    String chineseName;
    int subjectId;

    if (nameElement != null) {
      name = nameElement.text;
      chineseName = nameElement.attributes['title'];
      subjectId = tryParseInt(parseHrefId(nameElement, digitOnly: true));
    }
    name ??= '-';
    chineseName ??= '-';

    ListMultimap<String, InfoBoxItem> infoBoxRows =
        ListMultimap<String, InfoBoxItem>();

    ListMultimap<String, InfoBoxItem> curatedInfoBoxRows =
        ListMultimap<String, InfoBoxItem>();

    /// manually add subType as another [InfoBoxRow], this info is available
    /// in a difference place
    InfoBoxRow subTypeRow = parseSubjectSubtype(document);
    if (subTypeRow != null) {
      _addSeparatorIfNotFirstInfoBoxItem(
          infoBoxRows, subTypeRow.rowName, subTypeRow.rowItems);
      if (subTypeRow.isCuratedRow) {
        _addSeparatorIfNotFirstInfoBoxItem(
            curatedInfoBoxRows, subTypeRow.rowName, subTypeRow.rowItems);
      }
    }

    for (Element infoBoxRowElement
        in document.querySelectorAll('#infobox li')) {
      String infoBoxRowName =
          infoBoxRowElement.querySelector('span.tip')?.text ?? '';
      infoBoxRowName = infoBoxRowName.replaceAll(RegExp(r'\s+|:'), '');
      bool isCuratedRow =
          curatedRowMappings[subjectType].contains(infoBoxRowName);
      List<InfoBoxItem> infoBoxItems =
          parseInfoBoxRow(infoBoxRowElement, subjectType);

      _addSeparatorIfNotFirstInfoBoxItem(
          infoBoxRows, infoBoxRowName, infoBoxItems);

      if (isCuratedRow) {
        _addSeparatorIfNotFirstInfoBoxItem(
            curatedInfoBoxRows, infoBoxRowName, infoBoxItems);
      }
    }

    Element reviewElement = document.querySelector('#panelInterestWrapper');

    Rating rating = parseRating(reviewElement);

    SubjectCollectionInfoPreview preview = parseSubjectCollectionInfoPreview(
        reviewElement, document.querySelector('.rating[checked]'));

    int rank = tryParseInt(
        document
            .querySelector('.global_score .alarm')
            ?.text
            ?.replaceAll('#', ''),
        defaultValue: null);

    Element commonImageElement = document.querySelector('.infobox img.cover');
    BangumiImage cover = BangumiImage.fromImageUrl(
        imageSrcOrFallback(commonImageElement),
        ImageSize.Common,
        ImageType.SubjectCover);

    BuiltList<Character> characters = parseCharacters(document);

    BuiltList<SubjectReview> comments = parseReviews(document);

    BuiltListMultimap<String, RelatedSubject> relatedSubjects =
    _parseRelatedSubjects(document, subjectType);

    final tankobonSubjects =
    _parseTankobonSubjects(document, subjectType);

    String summary = document.querySelector('#subject_summary')?.text ?? '暂无简介';

    BuiltList<String> bangumiSuggestedTags =
        parseBangumiSuggestedTags(document);
    BuiltList<String> userSelectedTags = parseUserSelectedTags(document);

    final collectionStatusDistribution = parserCollectionStatusDistribution(
        document.querySelector('#columnSubjectHomeA'));

    final subjectProgressPreview =
        parseSubjectProgressPreview(document, subjectType);

    return BangumiSubject((b) => b
      ..infoBoxRows.replace(infoBoxRows)
      ..curatedInfoBoxRows.replace(curatedInfoBoxRows)
      ..id = subjectId
      ..type = subjectType
      ..subjectStatus = subjectStatus
      ..name = name
      ..chineseName = chineseName
      ..summary = summary
      ..rating.replace(rating)
      ..rank = rank
      ..cover.replace(cover)
      ..characters.replace(characters)
      ..commentsPreview.replace(comments)
      ..relatedSubjects.replace(relatedSubjects)
      ..tankobonSubjects.replace(tankobonSubjects)
      ..bangumiSuggestedTags.replace(bangumiSuggestedTags)
      ..userSelectedTags.replace(userSelectedTags)
      ..userSubjectCollectionInfoPreview.replace(preview)
      ..collectionStatusDistribution.replace(collectionStatusDistribution)
      ..subjectProgressPreview.replace(subjectProgressPreview));
  }
}
