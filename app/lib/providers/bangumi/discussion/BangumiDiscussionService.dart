import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/discussion/parser/isoldate.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/http/common.dart';

/// A Bangumi search service that handles search-related http requests
class BangumiDiscussionService {
  BangumiCookieService cookieClient;

  BangumiDiscussionService({@required this.cookieClient})
      : assert(cookieClient != null);

  Future<GetDiscussionResponse> getRakuenTopics(
      {@required GetDiscussionRequest getDiscussionRequest,
      @required MuteSetting muteSetting}) async {
    assert(getDiscussionRequest.discussionType == DiscussionType.Rakuen);
    assert(getDiscussionRequest.discussionFilter is RakuenTopicFilter);

    String requestUrl = '/rakuen/topiclist';

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

    List<DiscussionItem> discussionItems = await compute(
      processDiscussion,
      ParseDiscussionMessage(
        response.data,
        muteSetting,
      ),
    );

    GetDiscussionResponse getDiscussionResponse = GetDiscussionResponse((b) => b
      ..discussionItems.replace(BuiltSet<DiscussionItem>(discussionItems))
      ..appLastUpdatedAt = DateTime.now().toUtc());

    return getDiscussionResponse;
  }

  Future<GroupThread> getGroupThread({
    @required int threadId,
    @required BuiltMap<String, MutedUser> mutedUsers,
    Color captionTextColor = Colors.black54,
  }) async {
    String requestUrl = '/group/topic/$threadId';

    Dio.Response response = await cookieClient.dio.get(requestUrl);

    if (is2xxCode(response.statusCode)) {
      GroupThread thread = await compute(
          processGroupThread,
          ParseThreadMessage(
              response.data, mutedUsers, threadId, captionTextColor));
      return thread;
    }

    throw BangumiResponseIncomprehensibleException();
  }

  Future<EpisodeThread> getEpisodeThread({
    @required int threadId,
    @required BuiltMap<String, MutedUser> mutedUsers,
    Color captionTextColor = Colors.black54,
  }) async {
    String requestUrl = '/ep/$threadId';

    Dio.Response response = await cookieClient.dio.get(requestUrl);

    if (is2xxCode(response.statusCode)) {
      EpisodeThread thread = await compute(
          processEpisodeThread,
          ParseThreadMessage(
              response.data, mutedUsers, threadId, captionTextColor));
      return thread;
    }

    throw BangumiResponseIncomprehensibleException();
  }

  Future<SubjectTopicThread> getSubjectTopicThread({
    @required int threadId,
    @required BuiltMap<String, MutedUser> mutedUsers,
    Color captionTextColor = Colors.black54,
  }) async {
    String requestUrl = '/subject/topic/$threadId';

    Dio.Response response = await cookieClient.dio.get(requestUrl);

    if (is2xxCode(response.statusCode)) {
      SubjectTopicThread thread = await compute(
          processSubjectTopicThread,
          ParseThreadMessage(
              response.data, mutedUsers, threadId, captionTextColor));
      return thread;
    }

    throw BangumiResponseIncomprehensibleException();
  }

  Future<BlogThread> getBlogThread({
    @required int threadId,
    @required BuiltMap<String, MutedUser> mutedUsers,
    Color captionTextColor = Colors.black54,
  }) async {
    String requestUrl = '/blog/$threadId';

    Dio.Response response = await cookieClient.dio.get(requestUrl);

    if (is2xxCode(response.statusCode)) {
      BlogThread thread = await compute(
          processBlogThread,
          ParseThreadMessage(
              response.data, mutedUsers, threadId, captionTextColor));
      return thread;
    }

    throw BangumiResponseIncomprehensibleException();
  }
}
