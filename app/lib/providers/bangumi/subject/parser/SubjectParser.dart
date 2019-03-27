import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:munin/models/Bangumi/common/Images.dart';
import 'package:munin/models/Bangumi/mono/Actor.dart';
import 'package:munin/models/Bangumi/mono/Character.dart';
import 'package:munin/models/Bangumi/subject/Count.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxRow.dart';
import 'package:munin/models/Bangumi/subject/Rating.dart';
import 'package:munin/models/Bangumi/subject/RelatedSubject.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/models/Bangumi/subject/SubjectCollection.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectComment.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectCommentMetaInfo.dart';
import 'package:munin/models/Bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/strings.dart';

class SubjectParser {
  final curatedRowMappings = {
    SubjectType.Anime: {
    '话数', '动画制作', '原作', '制作', '监督', '放送开始'
    },
    SubjectType.Game: {'开发', '平台', '发行日期'},
    SubjectType.Music: {'艺术家', '厂牌', '发售日期'},
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
      '文库'
    },
    SubjectType.Real: {'国家/地区', '类型', '开始', '结束'},
  };

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
        ..id = parseHrefId(element)
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

  Rating parseRating(DocumentFragment subjectElement) {
    List<int> scoreArray = [];
    int totalVotesCount = 0;
    subjectElement.querySelectorAll('.horizontalChart li').forEach((element) {
      int scoreVotesCount = tryParseInt(element
          .querySelector('.count')
          ?.text
          ?.replaceAll(RegExp(r'\(|\)'), ''));
      totalVotesCount += scoreVotesCount;
      scoreArray.add(scoreVotesCount);
    });

    Count count = Count.fromDescendingScoreArray(scoreArray);
    double score = tryParseDouble(
        subjectElement.querySelector('[property="v:average"]')?.text);

    Element friendScoreElement = subjectElement.querySelector('.frdScore');
    int friendScoreVotesCount = extractFirstInt(
        friendScoreElement?.querySelector('a')?.text,
        defaultValue: null);

    double friendScore = tryParseDouble(
        friendScoreElement?.querySelector('.num')?.text,
        defaultValue: null);

    return Rating((b) => b
      ..score = score
      ..count.replace(count)
      ..total = totalVotesCount
      ..friendScore = friendScore
      ..friendScoreVotesCount = friendScoreVotesCount);
  }

  BuiltList<Actor> parseActors(Element characterElement) {
    List<Actor> actors = [];
    List<Element> actorElements =
        characterElement.querySelectorAll('a[rel=\"v:starring\"]');

    for (Element actorElement in actorElements) {
      int actorId = tryParseInt(parseHrefId(actorElement));
      String actorName = actorElement.text ?? '';
      actors.add(Actor((b) => b
        ..name = actorName
        ..id = actorId));
    }

    return BuiltList<Actor>(actors);
  }

  BuiltList<SubjectComment> parseComments(DocumentFragment subjectElement,
      {defaultActionName = '无评分'}) {
    List<Element> commentElements =
        subjectElement.querySelectorAll('#comment_box>.item');

    List<SubjectComment> comments = [];

    for (Element commentElement in commentElements) {
      Element avatarElement = commentElement.querySelector('a.avatar');
      int userId = tryParseInt(parseHrefId(avatarElement));
      String userAvatarSmall = imageUrlFromBackgroundImage(avatarElement);
      Images images = Images.fromImageUrl(
          userAvatarSmall, ImageSize.Unknown, ImageType.UserAvatar);
      String updatedAt = commentElement
              .querySelector('.grey')
              ?.text
              ?.replaceAll('@', '')
              ?.trim() ??
          '神秘时间';
      String commentContent = commentElement.querySelector('p')?.text ?? '';
      String nickName = commentElement.querySelector('.text > a')?.text ?? '';
      double score = parseSubjectScore(commentElement);

      String actionName = score == null ? defaultActionName : '';

      SubjectCommentMetaInfo metaInfo = SubjectCommentMetaInfo((b) => b
        ..updatedAt = updatedAt
        ..nickName = nickName
        ..actionName = actionName
        ..score = score
        ..userId = userId?.toString()
        ..images.replace(images));

      SubjectComment subjectComment = SubjectComment((b) => b
        ..content = commentContent
        ..metaInfo.replace(metaInfo));
      comments.add(subjectComment);
    }

    return BuiltList<SubjectComment>(comments);
  }

  BuiltList<Character> parseCharacters(DocumentFragment subjectElement) {
    List<Character> characters = [];

    List<Element> characterElements =
        subjectElement.querySelectorAll('.subject_section .user');

    for (Element characterElement in characterElements) {
      Element avatarElement = characterElement.querySelector('a.avatar');
      int characterId = tryParseInt(parseHrefId(avatarElement));
      String characterName = avatarElement?.text?.trim() ?? '';
      String roleName =
          characterElement.querySelector('.badge_job_tip')?.text ?? '';

      String characterImageSmall = imageUrlFromBackgroundImage(avatarElement);
      Images images = Images.fromImageUrl(
          characterImageSmall, ImageSize.Unknown, ImageType.CharacterAvatar);

      String collectionCountsStr =
          characterElement.querySelector('.fade.rr')?.text ?? '0';
      int collectionCounts = extractFirstInt(collectionCountsStr);
      BuiltList<Actor> actors = parseActors(characterElement);

      Character character = Character((b) => b
        ..id = characterId
        ..name = characterName
        ..roleName = roleName
        ..images.replace(images)
        ..collectionCounts = collectionCounts
        ..actors.replace(actors));
      characters.add(character);
    }

    return BuiltList<Character>(characters);
  }

  BuiltListMultimap<String, RelatedSubject> parseRelatedSubjects(
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
      int subjectId =
          tryParseInt(parseHrefId(subjectTitleElement), defaultValue: null);

      Element coverElement = subjectElement.querySelector('a.avatar');
      String subjectNameCn;
      Images images;

      if (coverElement != null) {
        subjectNameCn = coverElement.attributes['data-original-title'];
        String coverImage = imageUrlFromBackgroundImage(coverElement);
        coverImage ??= Images.defaultCoverImage;
        images = Images.fromImageUrl(
            coverImage, ImageSize.Unknown, ImageType.SubjectCover);
      }

      RelatedSubject relatedSubject = RelatedSubject((b) => b
        ..name = subjectName
        ..nameCn = subjectNameCn
        ..id = subjectId
        ..images.replace(images)
        ..subjectSubTypeName = subjectSubType);

      relatedSubjects.add(subjectSubType, relatedSubject);
    }

    if (subjectType != SubjectType.Book) {
      return BuiltListMultimap<String, RelatedSubject>(relatedSubjects);
    }

    /// it's possible book is associated with 单行本(tankobon), which is only
    /// valid for book
    List<Element> tankobonElements =
        subjectElement.querySelectorAll('.browserCoverSmall > li');

    String typeTankobon = '单行本';
    for (Element tankobonElement in tankobonElements) {
      Element coverElement = tankobonElement.querySelector('a.avatar');

      /// coverElement should not be null, if it is, it's unexpected so we
      /// silently continue
      if (coverElement == null) {
        continue;
      }

      int subjectId =
          tryParseInt(parseHrefId(coverElement), defaultValue: null);

      /// for Tankobon, subject original name is stored in `data-original-title`
      /// for non-Tankobon, subject chinese name is stored in `data-original-title`
      /// and in some browser(?), attribute `title` is used instead of `data-original-title`
      /// It's confusing but it is what Bangumi data is :(
      String subjectName = coverElement.attributes['data-original-title'];
      subjectName ??= coverElement.attributes['title'] ?? '';

      String coverImage = imageUrlFromBackgroundImage(coverElement);
      coverImage ??= Images.defaultCoverImage;
      Images images = Images.fromImageUrl(
          coverImage, ImageSize.Unknown, ImageType.SubjectCover);

      RelatedSubject relatedSubject = RelatedSubject((b) => b
        ..name = subjectName
        ..id = subjectId
        ..images.replace(images)
        ..subjectSubTypeName = typeTankobon);

      relatedSubjects.add(typeTankobon, relatedSubject);
    }

    return BuiltListMultimap<String, RelatedSubject>(relatedSubjects);
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

  /// in-place update [infoBoxRows] with [infoBoxItems]
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

  Subject process(String rawHtml) {
    DocumentFragment document = parseFragment(rawHtml);
    final SubjectType subjectType = SubjectType.getTypeByChineseName(
        document.querySelector('#navMenuNeue .focus')?.text);

    final nameElement = document.querySelector('.nameSingle > a');
    String name;
    String nameCn;
    int subjectId;

    if (nameElement != null) {
      name = nameElement.text;
      nameCn = nameElement.attributes['title'];
      subjectId = tryParseInt(parseHrefId(nameElement));
    }
    name ??= '-';
    nameCn ??= '-';

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
          infoBoxRowElement
              .querySelector('span.tip')
              ?.text ?? '';
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

    Rating rating = parseRating(document);

    int rank = tryParseInt(
        document
            .querySelector('.global_score .alarm')
            ?.text
            ?.replaceAll('#', ''),
        defaultValue: null);

    Element commonImageElement = document.querySelector('.infobox img.cover');
    Images images = Images.fromImageUrl(imageSrcOrNull(commonImageElement),
        ImageSize.Common, ImageType.SubjectCover);

    BuiltList<Character> characters = parseCharacters(document);

    BuiltList<SubjectComment> comments = parseComments(document);

    BuiltListMultimap<String, RelatedSubject> relatedSubjects =
        parseRelatedSubjects(document, subjectType);

    String summary = document
        .querySelector('#subject_summary')
        ?.text ?? '暂无简介';

    return Subject((b) => b
      ..infoBoxRows.replace(infoBoxRows)
      ..curatedInfoBoxRows.replace(curatedInfoBoxRows)
      ..id = subjectId
      ..type = subjectType
      ..name = name
      ..nameCn = nameCn
      ..summary = summary
      ..rating.replace(rating)
      ..rank = rank
      ..images.replace(images)
      ..characters.replace(characters)
      ..commentsPreview.replace(comments)
      ..relatedSubjects.replace(relatedSubjects));
  }

  /// currently not in use
  SubjectCollection parseSubjectCollection(DocumentFragment subjectElement) {
    Element subjectPanelCollectElement =
        subjectElement.querySelector('subjectPanelCollect');
    int wish = 0;
    int collect = 0;
    int doing = 0;
    int onHold = 0;
    int dropped = 0;

    return SubjectCollection((b) => b
      ..wish = wish
      ..collect = collect
      ..doing = doing
      ..onHold = onHold
      ..dropped = dropped);
  }
}
