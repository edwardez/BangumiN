import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/models/bangumi/timeline/message/FullPublicMessage.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/providers/bangumi/timeline/parser/isolate.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/http/common.dart';

/// bangumi returns 10 feeds each time, this currently cannot be changed
const int feedsPerPage = 10;

const int initialPageNum = 1;

// A Bangumi user service that handles user-related http requests and persist relevant info
class BangumiTimelineService {
  BangumiCookieService cookieClient;

  BangumiTimelineService({@required this.cookieClient})
      : assert(cookieClient != null);

  // Gets timeline on home page or user profile page by parsing html
  Future<GetTimelineParsedResponse> getTimeline({
    @required GetTimelineRequest request,
    @required int nextPageNum,
    @required FeedLoadType feedLoadType,
    @required int upperFeedId,
    @required int lowerFeedId,
    @required BuiltMap<String, MutedUser> mutedUsers,
    @required BangumiUserSmall userInfo,
  }) async {
    Map<String, dynamic> queryParameters = {'ajax': '1'};

    if (nextPageNum != null) {
      queryParameters['page'] = nextPageNum;
    }

    queryParameters['type'] =
        request.timelineCategoryFilter.bangumiQueryParameterValue;

    String requestPath;
    if (request.timelineSource == TimelineSource.UserProfile) {
      assert(request.username != null);
      requestPath = '/user/${request.username}/timeline';
    } else if (request.timelineSource == TimelineSource.OnlyFriends) {
      requestPath = '/timeline';
    } else {
      throw UnimplementedError('尚未支持读取这种时间线');
    }

    Response feedsHtml = await cookieClient.dio
        .get(requestPath, queryParameters: queryParameters);

    return await compute(
        processTimelineFeeds,
        ParseTimelineFeedsMessage(
          feedsHtml.data,
          feedLoadType: feedLoadType,
          upperFeedId: upperFeedId,
          lowerFeedId: lowerFeedId,
          timelineSource: request.timelineSource,
          userInfo: userInfo,
          mutedUsers: mutedUsers,
        ));
  }

  Future<void> deleteTimeline(int feedId) async {
    String xsrfToken = await cookieClient.getXsrfToken();

    Map<String, dynamic> queryParameters = {'ajax': '1', 'gh': xsrfToken};

    Response response = await cookieClient.dio.get('/erase/tml/$feedId',
        queryParameters: queryParameters,
        options: Options(
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.data);
      if (isBangumiWebPageOkResponse(decodedResponse)) {
        return;
      }
    }

    throw BangumiResponseIncomprehensibleException();
  }

  Future<void> submitTimelineMessage(String message) async {
    String xsrfToken = await cookieClient.getXsrfToken();

    Map<String, String> body = {
      'say_input': message,
      'formhash': xsrfToken,
      'submit': 'submit',
    };

    Map<String, dynamic> queryParameters = {'ajax': '1'};

    Response response = await cookieClient.dio.post('/update/user/say?ajax=1',
        queryParameters: queryParameters,
        data: body,
        options: Options(
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.data);
      if (isBangumiWebPageOkResponse(decodedResponse)) {
        return;
      }
    }

    throw BangumiResponseIncomprehensibleException();
  }

  /// Gets public message replies on bangumi and combines with input
  /// [publicMessageNormal] to build a [FullPublicMessage].
  Future<FullPublicMessage> getFullPublicMessage(PublicMessageNormal message,
      BuiltMap<String, MutedUser> mutedUsers,) async {
    Response response = await cookieClient.dio.get(
      '/user/${message.user.username}/timeline/status/${message.user
          .feedId}?ajax=1',
    );

    if (response.statusCode == 200) {
      return await compute(
          processFullPublicMessage,
          ParseFullPublicMessageMessage(
            response.data,
            publicMessageNormal: message,
            mutedUsers: mutedUsers,
          ));
    }

    throw BangumiResponseIncomprehensibleException();
  }

  Future<void> createPublicMessageReply(String reply,
      int feedId,) async {
    Map<String, String> formData = {
      // Not sure what's this for, related to bangumi-hosted image upload?
      'content': reply,
      'formhash': await cookieClient.getXsrfToken(),
      'submit': 'submit',
    };


    Response response = await cookieClient.dio.post(
      '/timeline/$feedId/new_reply?ajax=1',
      data: formData,
      options: Options(
        contentType: ExtraContentType.xWwwFormUrlencoded,
      ),
    );

    if (isBangumiWebPageOkResponse(jsonDecode(response.data))) {
      return;
    }

    throw BangumiResponseIncomprehensibleException();
  }
}
