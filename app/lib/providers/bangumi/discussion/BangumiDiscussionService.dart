import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/discussion/parser/DiscussionParser.dart';

/// A Bangumi search service that handles search-related http requests
class BangumiDiscussionService {
  BangumiCookieClient cookieClient;

  BangumiDiscussionService({@required this.cookieClient})
      : assert(cookieClient != null);

  /// Currently Mono search doesn't support pagination as Bangumi doesn't support
  /// (actually Bangumi has pagination for mono search, but second page is hidden)
  /// According to https://bgm.tv/group/topic/4428#post_56015, it seems like
  /// pagination is hidden intentionally
  Future<FetchDiscussionResponse> getRakuenTopics(
      {@required FetchDiscussionRequest fetchDiscussionRequest}) async {
    assert(fetchDiscussionRequest.discussionType == DiscussionType.Rakuen);
    assert(fetchDiscussionRequest.discussionFilter is RakuenTopicFilter);

    String requestUrl =
        '/rakuen/topiclist';

    Map<String, String> queryParameters = {};

    RakuenTopicFilter filter =
        fetchDiscussionRequest.discussionFilter as RakuenTopicFilter;

    /// [RakuenTopicFilter.Unrestricted] doesn't need a type filter
    /// otherwise we'll need to add one
    if (filter != RakuenTopicFilter.Unrestricted) {
      queryParameters['type'] = filter.toBangumiQueryParameterValue;
    }

    Dio.Response response = await cookieClient.dio
        .get(requestUrl, queryParameters: queryParameters);

    List<DiscussionItem> discussionItems =
        DiscussionParser().process(response.data);

    FetchDiscussionResponse fetchDiscussionResponse =
        FetchDiscussionResponse((b) => b
          ..discussionItems.replace(BuiltSet<DiscussionItem>(discussionItems))
          ..lastFetchedTime = DateTime.now().toUtc());

    return fetchDiscussionResponse;
  }
}
