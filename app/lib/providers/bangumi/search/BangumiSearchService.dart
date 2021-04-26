import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/search/SearchType.dart';
import 'package:munin/models/bangumi/search/result/BangumiGeneralSearchResponse.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/search/result/SubjectSearchResultItem.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/search/parser/isolate.dart';

/// A Bangumi search service that handles search-related http requests
class BangumiSearchService {
  /// Search query cannot start with illegal prefixes, otherwise Bangumi returns
  /// 403.
  static final _illegalSearchQueryPrefix = RegExp(r'^\.+');

  BangumiCookieService cookieClient;
  BangumiOauthService oauthClient;

  BangumiSearchService({@required this.cookieClient, @required this.oauthClient})
      : assert(cookieClient != null),
        assert(oauthClient != null);

  /// https://github.com/bangumi/api/issues/43 currently this API has a strange
  /// behaviour: if the result is empty, the API will take a long time to return
  /// a response
  /// another strange behaviour is a html might be returned, but the status code
  /// is 200
  Future<BangumiGeneralSearchResponse> searchSubject({
    @required String query,
    @required SearchType searchType,
    responseGroup = 'large',
    start = 0,
    maxResults = 25,
  }) async {
    query = query.replaceAll(_illegalSearchQueryPrefix, '');

    /// Some Bangumi search results depend on cookie chii_searchDateLine
    /// If this value is not set, bangumi might return html even though there
    /// does exist some results, so we need to set [chii_searchDateLine] cookie
    /// header here
    /// see https://github.com/bangumi/api/issues/43
    String requestUrlConst =
        'https://${Application.bangumiApiHost}/search/subject/'
        '$query?responseGroup=$responseGroup&start=$start&max_results=$maxResults';
    if (searchType.isConcreteSubjectType && searchType.wiredName != null) {
      requestUrlConst += '&type=${searchType.wiredName}';
    }

    Http.Response response = await oauthClient.client
        .get(Uri.parse(requestUrlConst), headers: {'Cookie': 'chii_searchDateLine=0}'});

    if (response.statusCode != 200) {
      print('Non 200 response ${response.body}');
    }

    final decodedBody = json.decode(response.body);

    if (decodedBody['code'] == 404) {
      return BangumiGeneralSearchResponse();
    }

    BangumiGeneralSearchResponse bangumiSearchResponse =
    BangumiGeneralSearchResponse.fromJson(response.body);

    LinkedHashMap<int, SubjectSearchResultItem> results =
    LinkedHashMap<int, SubjectSearchResultItem>();

    /// theoretically, this should be done in the serializer
    /// However custom serializer for [built_value] is not flexible enough and
    /// requires lots of boilerplate code. We hence implement custom json
    /// serializing logic here
    if (decodedBody['list'] != null) {
      for (var rawSubject in decodedBody['list']) {
        /// BuiltValueEnumConst requires wireName to be string
        rawSubject['type'] = rawSubject['type']?.toString();
        SubjectSearchResultItem subject =
        SubjectSearchResultItem.fromJson(json.encode(rawSubject));
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
  Future<BangumiGeneralSearchResponse> searchMono({@required String query, @required SearchType searchType}) async {
    assert(searchType.isMonoSearchType);

    String searchWiredName;
    if (searchType == SearchType.Person) {
      searchWiredName = 'prsn';
    } else if (searchType == SearchType.Character) {
      searchWiredName = 'crt';
    }

    String requestUrl = '/mono_search/$query?cat=$searchWiredName';

    Dio.Response response = await cookieClient.dio.get(requestUrl);
    LinkedHashMap<int, MonoSearchResult> monoSearchResults = await compute(
        processMonoSearch,
        ParseMonoSearchMessage(
          response.data,
          searchType: searchType,
        ));

    BangumiGeneralSearchResponse bangumiSearchResponse =
    BangumiGeneralSearchResponse((b) => b
      ..totalCount = monoSearchResults.length
      ..requestedResults = monoSearchResults.length
      ..results.addAll(monoSearchResults));

    return bangumiSearchResponse;
  }
}
