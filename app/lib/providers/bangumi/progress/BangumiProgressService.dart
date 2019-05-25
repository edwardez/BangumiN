import 'dart:collection';
import 'dart:convert' show json;

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/api/InProgressBookCollection.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/progress/parser/ProgressParser.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/http/common.dart';

/// A Bangumi search service that handles search-related http requests
class BangumiProgressService {
  BangumiCookieService cookieClient;
  BangumiOauthService oauthClient;

  BangumiProgressService(
      {@required this.cookieClient, @required this.oauthClient})
      : assert(cookieClient != null),
        assert(oauthClient != null);

  /// Updates a episode progress for an anime or real
  Future<void> updateSingleAnimeOrRealSingleEpisode(
      {@required int episodeId,
      @required EpisodeUpdateType episodeUpdateType}) async {
    assert(episodeUpdateType != EpisodeUpdateType.CollectUntil);

    Http.Response response = await oauthClient.client.post(
        'https://${Application.environmentValue.bangumiApiHost}/ep/$episodeId/status/${episodeUpdateType.wiredName}',
        body: {});

    var decodedBody = json.decode(response.body) ?? {};
    if (is2xxCode(response.statusCode) &&
        isBangumi2xxCode(decodedBody['code'])) {
      return Future.value();
    }

    debugPrint(
        'updateSingleAnimeOrRealSingleEpisode failed with ${response.body}');

    throw GeneralUnknownException('更新状态失败');
  }

  /// Updates multiple episodes progress for an anime or real
  Future<void> updateAnimeOrRealBatchEpisodes(
      {@required List<int> episodeIds}) async {
    Map<String, String> body = {};

    body['ep_id'] = episodeIds.join(',');

    Http.Response response = await oauthClient.client.post(
        'https://${Application.environmentValue.bangumiApiHost}/ep/${episodeIds.first}/status/${EpisodeUpdateType.Collect.wiredName}',
        body: body);

    var decodedBody = json.decode(response.body) ?? {};
    if (is2xxCode(response.statusCode) &&
        isBangumi2xxCode(decodedBody['code'])) {
      return Future.value();
    }

    debugPrint(
        'updateSingleAnimeOrRealSingleEpisode failed with ${response.body}');

    throw GeneralUnknownException('更新状态失败');
  }

  Future<void> updateBookProgress(
      {@required int subjectId,
      @required int newEpisodeNumber,
      @required int newVolumeNumber}) async {
    Map<String, String> body = {};
    if (newEpisodeNumber != null) {
      body['watched_eps'] = newEpisodeNumber.toString();
    }

    if (newVolumeNumber != null) {
      body['watched_vols'] = newVolumeNumber.toString();
    }

    Http.Response response = await oauthClient.client.post(
        'https://${Application.environmentValue.bangumiApiHost}/subject/$subjectId/update/watched_eps',
        body: body);

    var decodedBody = json.decode(response.body) ?? {};
    if (is2xxCode(response.statusCode) &&
        isBangumi2xxCode(decodedBody['code'])) {
      return Future.value();
    }

    debugPrint('_updateBatchEpisodeProgress failed with ${response.body}');

    throw GeneralUnknownException('更新状态失败');
  }

  /// Get all watchable subjects from API
  /// Watchable subject is defined as anime/real/(+books) by bangumi api
  /// if [includeBooks] is set to false, books won't be returned
  Future<LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>>
      getInProgressWatchableSubjectsFromApi(
          {@required String username,
          @required BuiltSet<SubjectType> subjectTypes}) async {
    assert(subjectTypes.isNotEmpty);
    assert(
        subjectTypes
            .difference(BuiltSet.of(SubjectType.validWatchableTypes))
            .isEmpty,
        '$subjectTypes contains at least one subject type that\'s not watchable');

    String category =
        subjectTypes.contains(SubjectType.Book) ? 'all_watching' : 'watching';

    /// Fist gets the following info from api
    /// 1. All anime/real/(+books) that user are watching
    /// 2. Among these subjects, all episodes that user has touched
    List<Http.Response> responses = await Future.wait([
      oauthClient.client.get(
          'https://${Application.environmentValue.bangumiApiHost}/user/$username/collection?cat=$category&responseGroup=medium'),
      oauthClient.client.get(
          'https://${Application.environmentValue.bangumiApiHost}/user/$username/progress')
    ]);
    Http.Response collectionResponse = responses[0];
    Http.Response inProgressEpisodesResponse = responses[1];

    if (!is2xxCode(collectionResponse.statusCode) ||
        !is2xxCode(inProgressEpisodesResponse.statusCode)) {
      throw GeneralUnknownException('出现了未知错误: Bangumi此刻无法响应请求');
    }

    var decodedCollection = json.decode(collectionResponse.body) ?? [];
    var decodedEpisodes = json.decode(inProgressEpisodesResponse.body) ?? [];
    if (decodedCollection is! List || decodedEpisodes is! List) {
      /// otherwise, Munin cannot understand this response
      throw BangumiResponseIncomprehensibleException(
          '出现了未知错误: 从Bangumi返回了无法处理的数据');
    }

    /// 3. Groups touched subjects by subject id
    LinkedHashMap<int, Map<int, Map>> touchedEpisodesPerSubjectId =
        LinkedHashMap<int, Map<int, Map>>();
    for (var rawEpisodeProgress in decodedEpisodes) {
      var subjectId = rawEpisodeProgress['subject_id'];

      if (subjectId is! int || rawEpisodeProgress['eps'] is! List) {
        debugPrint(
            'Recevied unknown episode progress data $rawEpisodeProgress');
        continue;
      }
      touchedEpisodesPerSubjectId[subjectId] =
          (rawEpisodeProgress['eps'] as List).fold({}, (mapSoFar, episode) {
        mapSoFar[episode['id']] = episode;
        return mapSoFar;
      });
    }

    /// 4.1 If only book info is requested, parses collection info and returns
    if (subjectTypes.contains(SubjectType.Book) && subjectTypes.length == 1) {
      return _serializeWatchableBookCollection(decodedCollection);
    }

    /// 4.2 If anime/real is also requested, get their episodes info as well by parsing html
    LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>> episodesPerSubject =
        await getInProgressWatchingEpisodesFromHtml(
            touchedEpisodesPerSubjectId: touchedEpisodesPerSubjectId);

    /// 5. Adds episodes info to the model and serializes data
    return _serializeAllWatchableCollection(
        decodedCollection, episodesPerSubject, subjectTypes);
  }

  /// Note i. If the subject has lots of episodes, only most recent episodes will be returned
  /// Note ii. This method returns all episodes that user can modify status, regardless user
  /// has touched them or not(same method in api only returns subjects user has touched)
  /// By default this method returns all [EpisodeProgress.userEpisodeStatus] as [EpisodeStatus.Unknown]
  /// If [touchedEpisodesPerSubjectId] is passed in, it updates [userEpisodeStatus] accordingly
  Future<LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>>>
      getInProgressWatchingEpisodesFromHtml(
          {LinkedHashMap<int, Map<int, Map>>
              touchedEpisodesPerSubjectId}) async {
    Dio.Response<String> response =
        await cookieClient.dio.get<String>('/m/prg');

    LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>> episodesPerSubject =
        ProgressParser().processProgressPreview(response.data);
    if (touchedEpisodesPerSubjectId != null) {
      episodesPerSubject.forEach((subjectId, episodes) {
        for (EpisodeProgress episode in episodes.values) {
          int episodeId = episode.id;

          if (touchedEpisodesPerSubjectId[subjectId] == null ||
              touchedEpisodesPerSubjectId[subjectId][episodeId] == null ||
              touchedEpisodesPerSubjectId[subjectId][episodeId]['status'] ==
                  null ||
              touchedEpisodesPerSubjectId[subjectId][episodeId]['status']
                      ['id'] ==
                  null) {
            if (touchedEpisodesPerSubjectId[subjectId] != null &&
                touchedEpisodesPerSubjectId[subjectId][episodeId] != null) {
              assert(touchedEpisodesPerSubjectId[subjectId][episodeId]
                          ['status'] !=
                      null &&
                  touchedEpisodesPerSubjectId[subjectId][episodeId]['status']
                          ['id'] !=
                      null);
            }

            episodes[episodeId] = episode
                .rebuild((b) => b..userEpisodeStatus = EpisodeStatus.Untouched);
          } else {
            String wiredName = touchedEpisodesPerSubjectId[subjectId][episodeId]
                    ['status']['id']
                .toString();
            episodes[episodeId] = episode.rebuild((b) =>
                b..userEpisodeStatus = EpisodeStatus.fromWiredName(wiredName));
          }
        }
      });
    }

    return episodesPerSubject;
  }

  LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>
      _serializeWatchableBookCollection(dynamic decodedCollection) {
    LinkedHashMap<SubjectType,
        LinkedHashMap<int, InProgressCollection>> progress =
    LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>();
    progress[SubjectType.Book] = LinkedHashMap<int, InProgressCollection>();

    for (var rawCollection in decodedCollection) {
      /// BuiltValueEnumConst requires wireName to be string
      rawCollection['subject']['type'] =
          rawCollection['subject']['type']?.toString();

      if (rawCollection['subject']['type'] != SubjectType.Book.wiredName) {
        continue;
      }

      InProgressCollection inProgressSubject =
          InProgressBookCollection.fromJson(json.encode(rawCollection));

      progress[inProgressSubject.subject.type]
          .addAll({inProgressSubject.subject.id: inProgressSubject});
    }
    return progress;
  }

  LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>
      _serializeAllWatchableCollection(
    dynamic decodedCollection,
    LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>> episodesPerSubject,
    BuiltSet<SubjectType> requestedSubjectTypes,
  ) {
    LinkedHashMap<SubjectType,
        LinkedHashMap<int, InProgressCollection>> progress =
    LinkedHashMap<SubjectType, LinkedHashMap<int, InProgressCollection>>();

    requestedSubjectTypes.forEach((subjectType) {
      progress[subjectType] = LinkedHashMap<int, InProgressCollection>();
    });

    /// Adds episodes info to the model and serializes data
    for (var rawCollection in decodedCollection) {
      if (rawCollection['subject'] == null ||
          rawCollection['subject']['type'] == null) {
        debugPrint('Recevied unknown collection $rawCollection');
        continue;
      }

      /// BuiltValueEnumConst requires wireName to be string
      rawCollection['subject']['type'] =
          rawCollection['subject']['type']?.toString();

      /// if not in requested subject type, just continue
      if (!requestedSubjectTypes.contains(
          SubjectType.fromWiredName(rawCollection['subject']['type']))) {
        continue;
      }

      InProgressCollection inProgressSubject;

      if (rawCollection['subject']['type'] == SubjectType.Book.wiredName) {
        inProgressSubject =
            InProgressBookCollection.fromJson(json.encode(rawCollection));
      } else {
        InProgressAnimeOrRealCollection inProgressAnimeOrReal =
            InProgressAnimeOrRealCollection.fromJson(
                json.encode(rawCollection));

        LinkedHashMap<int, EpisodeProgress> episodes =
            episodesPerSubject[inProgressAnimeOrReal.subject.id] ??
                LinkedHashMap<int, EpisodeProgress>();
        inProgressAnimeOrReal =
            inProgressAnimeOrReal.rebuild((b) => b..episodes.replace(episodes));

        inProgressSubject = inProgressAnimeOrReal;
      }

      if (progress[inProgressSubject.subject.type] == null) {
        continue;
      }

      progress[inProgressSubject.subject.type]
          .addAll({inProgressSubject.subject.id: inProgressSubject});
    }

    return progress;
  }
}
