import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:html/parser.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/common/AirStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';

class ProgressParser {
  AirStatus parseAirStatus(String rawAirStatusName) {
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

  LinkedHashMap<int, EpisodeProgress> parseEpisodes(
      Element subjectElement, Map<int, Element> episodeDetailElements) {
    LinkedHashMap<int, EpisodeProgress> episodes =
        LinkedHashMap<int, EpisodeProgress>();
    List<Element> episodePanelChildElements =
        subjectElement.querySelector('.epPanel')?.children ?? [];

    bool isSpecialEpisode = false;

    /// It's possible an on air subject doesn't have any episodes
    /// i.e. a movie
    /// All userEpisodeStatus will be initialized as [EpisodeStatus.Unknown]
    /// because parsing html is fragile and this info can be reliably retrieved from api
    for (Element element in episodePanelChildElements) {
      /// All episode element after a span with `.subtitle` are special episodes
      if (element.localName == 'span' && element.classes.contains('subtitle')) {
        isSpecialEpisode = true;
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
      AirStatus airStatus = parseAirStatus(element.className);

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
        ..episodeType = isSpecialEpisode
            ? EpisodeType.NonRegularEpisode
            : EpisodeType.RegularEpisode);

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
}
