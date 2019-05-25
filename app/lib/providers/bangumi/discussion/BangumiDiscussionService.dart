import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/discussion/parser/DiscussionParser.dart';

/// A Bangumi search service that handles search-related http requests
class BangumiDiscussionService {
  BangumiCookieService cookieClient;

  BangumiDiscussionService({@required this.cookieClient})
      : assert(cookieClient != null);


  Future<GetDiscussionResponse> getRakuenTopics(
      {@required GetDiscussionRequest getDiscussionRequest, @required MuteSetting muteSetting}) async {
    assert(getDiscussionRequest.discussionType == DiscussionType.Rakuen);
    assert(getDiscussionRequest.discussionFilter is RakuenTopicFilter);

    String requestUrl =
        '/rakuen/topiclist';

    Map<String, String> queryParameters = {};

    RakuenTopicFilter filter =
    getDiscussionRequest.discussionFilter as RakuenTopicFilter;

    /// [RakuenTopicFilter.Unrestricted] doesn't need a type filter
    /// otherwise we'll need to add one
    if (filter != RakuenTopicFilter.Unrestricted) {
      queryParameters['type'] = filter.toBangumiQueryParameterValue;
    }

    Dio.Response response = await cookieClient.dio
        .get(requestUrl, queryParameters: queryParameters);

    List<DiscussionItem> discussionItems =
    DiscussionParser().process(response.data, muteSetting: muteSetting);

    GetDiscussionResponse getDiscussionResponse =
    GetDiscussionResponse((b) =>
    b
          ..discussionItems.replace(BuiltSet<DiscussionItem>(discussionItems))
      ..appLastUpdatedAt = DateTime.now().toUtc());

    return getDiscussionResponse;
  }
}
