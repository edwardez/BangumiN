import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/enums/DiscussionType.dart';
import 'package:munin/models/bangumi/discussion/enums/RakuenFilter.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/discussion/parser/isoldate.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
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

  /// Creates reply. Throws exception if reply is not successfully created.
  ///
  /// An optional [targetPost] can be used to send
  Future<void> createReply({
    @required int threadId,
    @required ThreadType threadType,
    @required String reply,
    @required BangumiUserSmall author,
    Post targetPost,
  }) async {
    String url;
    switch (threadType) {
      case ThreadType.Blog:
        url = '/blog/entry/$threadId/new_reply';
        break;
      case ThreadType.Group:
        url = '/group/topic/$threadId/new_reply';
        break;
      case ThreadType.SubjectTopic:
        url = '/subject/topic/$threadId/new_reply';
        break;
      case ThreadType.Episode:
      default:
        if (threadType != ThreadType.Episode) {
          throw ArgumentError('$threadType must be ${ThreadType.Episode}');
        }
        url = '/subject/ep/$threadId/new_reply';
        break;
    }

    Map<String, String> queryParameters = {'ajax': '1'};

    Map<String, String> formData = {
      // Not sure what's this for, related to bangumi-hosted image upload?
      'related_photo': '0',
      'lastview': '${DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000}',
      'submit': 'submit',
    };

    formData['formhash'] = await cookieClient.getXsrfToken();

    if (targetPost is SubPostReply || targetPost is MainPostReply) {
      formData['topic_id'] = '${author.id}';

      formData['sub_reply_uid'] = '${author.id}';
      formData['post_uid'] = targetPost.author.id.toString();
      formData['content'] = reply;

      if (targetPost is SubPostReply) {
        // A reply is always related to its main post. But never actually
        // associated with its target [SubPostReply]. Bangumi is just mocking
        // the association on web page.
        formData['related'] = targetPost.mainPostId.toString();
        // trims quoted text as the same style bangumi is using.
        String quotedText = '[quote][b]${targetPost.author.nickname}[/b] 说: '
            '${firstNChars(targetPost.authorPostedText, 100)} [/quote]\n';

        formData['content'] = '$quotedText$reply';
      } else if (targetPost is MainPostReply) {
        formData['related'] = targetPost.id.toString();
      }
    } else {
      formData['content'] = reply;
    }

    final response = await cookieClient.dio.post(
      url,
      data: formData,
      queryParameters: queryParameters,
      options: Dio.Options(
        contentType: ExtraContentType.xWwwFormUrlencoded,
      ),
    );

    final decodedResponseBody = jsonDecode(response.data);

    if (!isBangumiWebPageOkResponse(decodedResponseBody)) {
      throw GeneralUnknownException('发表回复失败');
    }
  }

  /// Removes a reply on bangumi.
  Future<void> deleteReply({
    @required int replyId,
    @required ThreadType threadType,
  }) async {
    String url;
    switch (threadType) {
      case ThreadType.Blog:
        url = '/erase/reply/blog/$replyId';
        break;
      case ThreadType.Group:
        url = '/erase/group/reply/$replyId';
        break;
      case ThreadType.SubjectTopic:
        url = '/erase/subject/reply/$replyId';
        break;
      case ThreadType.Episode:
      default:
        if (threadType != ThreadType.Episode) {
          throw ArgumentError('$threadType must be ${ThreadType.Episode}');
        }
        url = '/erase/reply/ep/$replyId';
        break;
    }

    Map<String, String> queryParameters = {
      'ajax': '1',
      'gh': await cookieClient.getXsrfToken(),
    };

    final response = await cookieClient.dio.get(
      url,
      queryParameters: queryParameters,
      options: Dio.Options(
        contentType: ExtraContentType.xWwwFormUrlencoded,
      ),
    );

    final decodedResponseBody = jsonDecode(response.data);

    if (!isBangumiWebPageOkResponse(decodedResponseBody)) {
      throw GeneralUnknownException('删除回复失败');
    }
  }

  static urlForEditOrGetReply({
    @required int replyId,
    @required ThreadType threadType,
  }) {
    String url;
    switch (threadType) {
      case ThreadType.Blog:
        url = '/blog/reply/edit/$replyId';
        break;
      case ThreadType.Group:
        url = '/group/reply/$replyId/edit';
        break;
      case ThreadType.SubjectTopic:
        url = '/subject/reply/$replyId/edit';
        break;
      case ThreadType.Episode:
      default:
        if (threadType != ThreadType.Episode) {
          throw ArgumentError('$threadType must be ${ThreadType.Episode}');
        }
        url = '/subject/ep/edit_reply/$replyId';
        break;
    }
    return url;
  }
}
