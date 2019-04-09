import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/BangumiSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResult.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/search/parser/MonoSearchParser.dart';

/// A Bangumi search service that handles search-related http requests
class BangumiSearchService {
  BangumiCookieClient cookieClient;
  BangumiOauthClient oauthClient;

  BangumiSearchService(
      {@required this.cookieClient, @required this.oauthClient})
      : assert(cookieClient != null),
        assert(oauthClient != null);

  /// https://github.com/bangumi/api/issues/43 currently this API has a strange
  /// behaviour: if the result is empty, the API will take a long time to return
  /// a response
  /// another strange behaviour is a html might be returned, but the status code
  /// is 200
  Future<BangumiSearchResponse> searchSubject({
    @required String query,
    @required SearchType searchType,
    responseGroup = 'large',
    start = 0,
    maxResults = 25,
  }) async {
    /// Some Bangumi search results depend on cookie chii_searchDateLine
    /// If this value is not set, bangumi might return html even though there
    /// does exist some results, so we need to set [chii_searchDateLine] cookie
    /// header here
    /// see https://github.com/bangumi/api/issues/43
    String requestUrl =
        'https://${Application.environmentValue.bangumiApiHost}/search/subject/'
        '$query?responseGroup=$responseGroup&start=$start&max_results=$maxResults';
    if (searchType.wiredName != null) {
      requestUrl += '&type=${searchType.wiredName}';
    }

    Http.Response response = await oauthClient.client
        .get(requestUrl, headers: {'Cookie': 'chii_searchDateLine=0}'});

    if (response.statusCode != 200) {
      print('Non 200 response ${response.body}');
    }

    final decodedBody = json.decode(response.body);

    if (decodedBody['code'] == 404) {
      return BangumiSearchResponse();
    }

    BangumiSearchResponse bangumiSearchResponse =
        BangumiSearchResponse.fromJson(response.body);

    LinkedHashMap<int, SubjectSearchResult> results =
        LinkedHashMap<int, SubjectSearchResult>();

    /// theoretically, this should be done in the serializer
    /// However custom serializer for [built_value] is not flexible enough and
    /// requires lots of boilerplate code. We hence implement custom json
    /// serializing logic here
    if (decodedBody['list'] != null) {
      for (var rawSubject in decodedBody['list']) {
        /// BuiltValueEnumConst requires wireName to be string
        rawSubject['type'] = rawSubject['type']?.toString();
        SubjectSearchResult subject =
            SubjectSearchResult.fromJson(json.encode(rawSubject));
        results[subject.id] = subject;
      }
    }

    bangumiSearchResponse = bangumiSearchResponse.rebuild((b) => b
      ..results.replace(results)
      ..requestedResults = math.max(maxResults, results.length));

    return bangumiSearchResponse;
  }

  /// Currently Mono search doesn't support pagination as Bangumi doesn't support
  /// (actually Bangumi has pagination for mono search, but second page is hidden)
  /// According to https://bgm.tv/group/topic/4428#post_56015, it seems like
  /// pagination is hidden intentionally
  Future<BangumiSearchResponse> searchMono(
      {@required String query, @required SearchType searchType}) async {
    assert(searchType.isMonoSearchType);

    String searchWiredName;
    if (searchType == SearchType.Person) {
      searchWiredName = 'prsn';
    } else if (searchType == SearchType.Character) {
      searchWiredName = 'crt';
    }

    String requestUrl =
        'https://${Application.environmentValue
        .bangumiMainHost}/mono_search/$query?cat=$searchWiredName';

    Dio.Response response = await cookieClient.dio.get(requestUrl);
    LinkedHashMap<int, MonoSearchResult> monoSearchResults =
    MonoSearchParser().process(response.data);

    BangumiSearchResponse bangumiSearchResponse = BangumiSearchResponse((b) =>
    b
      ..totalCount = monoSearchResults.length
      ..requestedResults = monoSearchResults.length
      ..results.addAll(monoSearchResults));

    return bangumiSearchResponse;
  }
}
