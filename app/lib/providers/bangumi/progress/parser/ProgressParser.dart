import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:html/parser.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/models/bangumi/progress/html/SimpleHtmlBasedEpisode.dart';
import 'package:munin/models/bangumi/progress/html/SubjectEpisodes.dart';
import 'package:munin/providers/bangumi/discussion/parser/common.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';

class ProgressParser {
  static final normalizeEpisodeInfoRegex = RegExp(r'\s?\/\s?');
  static final dummyEpisodeNameSymbolRegex = RegExp(r'^\s+\/\s+');
  static final episodeInfoKeywordRegex = RegExp(r'时长|首播|讨论');

  static AirStatus guessAirStatusByButtonClassName(String rawAirStatusName) {
    switch (rawAirStatusName) {
      case 'epBtnAir':
        return AirStatus.Aired;
      case 'epBtnToday':
        return AirStatus.OnAir;
      case 'epBtnNA':
        return AirStatus.NotAired;
      case 'epBtnWatched':
      default:
        return AirStatus.Unknown;
    }
  }

  static AirStatus guessAirStatusByChinese(String chineseName) {
    if (chineseName == null) {
      return AirStatus.Unknown;
    }

    for (var status in AirStatus.values) {
      if (chineseName.contains(status.chineseName)) {
        return status;
      }
    }

    return AirStatus.Unknown;
  }

  static EpisodeType guessEpisodeTypeByChineseName(String chineseName) {
    if (chineseName == null) {
      return EpisodeType.Unknown;
    }

    List<EpisodeType> episodeTypes = [
      EpisodeType.Regular,
      EpisodeType.Special,
      EpisodeType.Opening,
      EpisodeType.Ending,
      EpisodeType.Trailer,
      EpisodeType.OtherNonRegular,
    ];

    for (var episodeType in episodeTypes) {
      if (chineseName.contains(episodeType.chineseName)) {
        return episodeType;
      }
    }

    String splitter = EpisodeType.trailerChineseNameSplitter;

    /// Gets notified if [EpisodeType.Trailer.chineseName] is updated but
    /// someone forgets to update this method.
    assert(EpisodeType.Trailer.chineseName == '预告$splitter宣传$splitter广告');

    for (var trailerKeyword
    in EpisodeType.Trailer.chineseName.split(splitter)) {
      if (chineseName.contains(trailerKeyword)) {
        return EpisodeType.Trailer;
      }
    }

    return EpisodeType.Unknown;
  }

  LinkedHashMap<int, EpisodeProgress> parseEpisodes(
      Element subjectElement, Map<int, Element> episodeDetailElements) {
    LinkedHashMap<int, EpisodeProgress> episodes =
        LinkedHashMap<int, EpisodeProgress>();
    List<Element> episodePanelChildElements =
        subjectElement.querySelector('.epPanel')?.children ?? [];

    bool isUnknownNonRegular = false;

    /// It's possible an on air subject doesn't have any episodes
    /// i.e. a movie
    /// All userEpisodeStatus will be initialized as [EpisodeStatus.Unknown]
    /// because parsing html is fragile and this info can be reliably retrieved from api
    for (Element element in episodePanelChildElements) {
      /// All episode element after a span with `.subtitle` are special episodes
      if (element.localName == 'span' && element.classes.contains('subtitle')) {
        isUnknownNonRegular = true;
      }

      /// We are only interested in a element, which is an episode element
      if (element.localName != 'a') {
        continue;
      }

      int episodeId = extractFirstIntGroup(element.id, defaultValue: null);
      if (episodeId == null) {
        debugPrint('Recevied unknown subject ${element.outerHtml}');
        continue;
      }

      String name = element.attributes['title'] ?? '';
      double sequentialNumber =
          tryParseDouble(element.text.trim(), defaultValue: 0);
      AirStatus airStatus = guessAirStatusByButtonClassName(element.className);

      String nameCn;
      String duration;
      String airDate;
      int totalCommentsCount;
      Element episodeDetailElement =
          episodeDetailElements[episodeId] ?? Element.tag('div');
      NodeList detailNodes = episodeDetailElement.nodes;

      for (Node detailNode in detailNodes) {
        if (detailNode.text.startsWith('中文标题')) {
          nameCn = firstCapturedStringOrNull(
              contentAfterFistColonGroupRegex, detailNode.text);
        } else if (detailNode.text.startsWith('首播')) {
          airDate = firstCapturedStringOrNull(
              contentAfterFistColonGroupRegex, detailNode.text);
        } else if (detailNode.text.startsWith('时长')) {
          duration = firstCapturedStringOrNull(
              contentAfterFistColonGroupRegex, detailNode.text);
        } else if (detailNode.text.startsWith('讨论')) {
          totalCommentsCount =
              extractFirstIntGroup(detailNode.text, defaultValue: 0);
        }
      }

      nameCn ??= '';
      duration ??= '';
      airDate ??= '';
      totalCommentsCount ??= 0;

      EpisodeProgress episodeProgress = EpisodeProgress((b) => b
        ..id = episodeId
        ..name = name
        ..nameCn = nameCn
        ..airStatus = airStatus
        ..duration = duration
        ..sequentialNumber = sequentialNumber
        ..airDate = airDate
        ..totalCommentsCount = totalCommentsCount
        ..userEpisodeStatus = EpisodeStatus.Unknown
        ..episodeType =
        isUnknownNonRegular ? EpisodeType.Unknown : EpisodeType.Regular);

      episodes[episodeId] = episodeProgress;
    }

    return episodes;
  }

  /// parse https://bgm.tv/m/prg
  LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>>
      processProgressPreview(String rawHtml) {
    DocumentFragment document = parseFragment(rawHtml);

    LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>> episodesPerSubject =
        LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>>();

    List<Element> subjects =
        document.querySelectorAll('.infoWrapper_tv > .subjectItem');

    Map<int, Element> episodeDetailElements = {};

    for (Element detailElement in document.querySelectorAll('.prg_popup')) {
      int episodeId =
          extractFirstIntGroup(detailElement.id, defaultValue: null);
      Element tipElement = detailElement.querySelector('.tip');
      if (episodeId == null || tipElement == null) {
        debugPrint('Recevied unknown subject ${detailElement.outerHtml}');
        continue;
      }

      episodeDetailElements[episodeId] = tipElement;
    }

    for (Element subjectElement in subjects) {
      int subjectId =
          extractFirstIntGroup(subjectElement.id, defaultValue: null);
      if (subjectId == null) {
        debugPrint('Recevied unknown subject ${subjectElement.outerHtml}');
        continue;
      }

      episodesPerSubject[subjectId] =
          parseEpisodes(subjectElement, episodeDetailElements);
    }

    return episodesPerSubject;
  }

  BuiltMap<int, SimpleHtmlBasedEpisode> parseSubjectEpisodes(
      List<Element> episodeElements,
      Map<int, EpisodeStatus> touchedEpisodes,) {
    EpisodeType episodeType = EpisodeType.Unknown;

    BuiltMap<int, SimpleHtmlBasedEpisode> episodes =
    BuiltMap<int, SimpleHtmlBasedEpisode>();
    for (var episodeElement in episodeElements) {
      if (episodeElement.classes.contains('cat')) {
        episodeType = guessEpisodeTypeByChineseName(episodeElement.text.trim());
        continue;
      }

      Element episodeLinkElement;
      int episodeId;
      for (var maybeLinkElement
      in episodeElement.querySelectorAll('a[href*="/ep/"]')) {
        if (maybeLinkElement.classes.contains('ep_status')) {
          /// This is a link with episode status, not something we are looking for.
          continue;
        }

        episodeId = tryParseInt(parseHrefId(maybeLinkElement, digitOnly: true),
            defaultValue: null);
        if (episodeId != null) {
          episodeLinkElement = maybeLinkElement;
          break;
        }
      }

      /// This is not a valid episode element, continue.
      if (episodeLinkElement == null) {
        continue;
      }

      String name = episodeLinkElement.text;

      String nameCn = '';

      Element maybeChineseNameElement = episodeLinkElement.nextElementSibling;
      if (maybeChineseNameElement != null &&
          maybeChineseNameElement.classes.contains('tip')) {
        nameCn = maybeChineseNameElement.text
            .replaceFirst(dummyEpisodeNameSymbolRegex, '');
      }

      String episodeInfo = '';

      for (var maybeEpisodeInfoElement
      in episodeElement.querySelectorAll('.grey')) {
        if (maybeEpisodeInfoElement.text.contains(episodeInfoKeywordRegex)) {
          episodeInfo += maybeEpisodeInfoElement.text;
        }
      }

      // bangumi html might returns something like
      // 时长:00:12:15/首播:2019-04-19
      // Normalizes it so every splitter `/` has spaces before and after.
      episodeInfo = episodeInfo.replaceAll(normalizeEpisodeInfoRegex, ' / ');

      // Further more, if episode info starts with splitter, trims it out.
      if (episodeInfo.startsWith(normalizeEpisodeInfoRegex)) {
        episodeInfo = episodeInfo.replaceFirst(normalizeEpisodeInfoRegex, '');
      }

      AirStatus airStatus = guessAirStatusByChinese(
          elementOrEmptyDiv(episodeElement.querySelector('.epAirStatus'))
              .attributes['title']);

      // Episode must have a valid type.
      assert(episodeType != EpisodeType.Unknown);

      SimpleHtmlBasedEpisode episode = SimpleHtmlBasedEpisode((b) =>
      b
        ..id = episodeId
        ..name = name
        ..nameCn = nameCn
        ..airStatus = airStatus
        ..episodeInfo = episodeInfo
        ..userEpisodeStatus = touchedEpisodes[episodeId] ??
            EpisodeStatus.Pristine
        ..episodeType = episodeType);

      episodes = episodes.rebuild((b) => b..addAll({episode.id: episode}));
    }

    return episodes;
  }

  SubjectEpisodes progressSubjectEpisodes(String rawHtml,
      Map<int, EpisodeStatus> touchedEpisodes) {
    DocumentFragment document = parseFragment(rawHtml);
    List<Element> episodeElements =
    document.querySelectorAll('.line_list > li');

    final episodes = parseSubjectEpisodes(episodeElements, touchedEpisodes);

    return SubjectEpisodes((b) =>
    b
      ..subject.replace(parseParentSubject(document).orNull)
      ..episodes.replace(episodes));
  }
}
