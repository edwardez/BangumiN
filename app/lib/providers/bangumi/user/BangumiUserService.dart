import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/user/parser/ImportBlockedUserParser.dart';
import 'package:munin/providers/bangumi/user/parser/UserCollectionsListParser.dart';
import 'package:munin/providers/bangumi/user/parser/isolate.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/http/common.dart';

// A Bangumi user service that handles user-related http requests and persist relevant info
class BangumiUserService {
  SharedPreferenceService sharedPreferenceService;
  BangumiOauthService oauthClient;
  BangumiCookieService cookieClient;

  BangumiUserService({@required this.oauthClient,
    @required this.cookieClient,
    @required this.sharedPreferenceService})
      : assert(oauthClient != null),
        assert(cookieClient != null),
        assert(sharedPreferenceService != null);

  // persist current bangumi user basic info through api
  Future<BangumiUserSmall> persistCurrentUserBasicInfo(String username) async {
    BangumiUserSmall basicInfo = await getUserBasicInfo(username);
    return basicInfo;
  }

  // get bangumi user basic info through api
  Future<BangumiUserSmall> getUserBasicInfo(String username) async {
    final response = await oauthClient.client.get(
        'https://${Application.bangumiApiHost}/user/$username');

    BangumiUserSmall basicInfo = BangumiUserSmall.fromJson(response.body);
    return basicInfo;
  }

  // Gets bangumi user basic info through api
  Future<UserProfile> getUserPreview(String username) async {
    final response = await cookieClient.dio.get<String>('/user/$username');

    return await compute(processUserProfile, response.data);
  }

  // Imports blocked users
  Future<BuiltMap<String, MutedUser>> importBlockedUser() async {
    final response = await cookieClient.dio.get<String>('/settings/privacy');

    BuiltMap<String, MutedUser> users =
    ImportBlockedUserParser().process(response.data);
    return users;
  }

  /// Lists collections on page [webPageNumber].
  /// Note that [webPageNumber] starts from 1(aligns with how bangumi counts
  /// web page).
  Future<ParsedCollections> listUserCollections({@required ListUserCollectionsRequest request,
    @required int webPageNumber}) async {
    final username = request.username;
    final subjectTypeName = request.subjectType.name.toLowerCase();
    final collectionStatusName = request.collectionStatus.wiredName;

    Map<String, String> queryParameters = {};
    if (webPageNumber >= 2) {
      queryParameters['page'] = webPageNumber.toString();
    }

    final maybeOrderByWiredName = request.orderCollectionBy.wiredName;
    if (maybeOrderByWiredName.isPresent) {
      queryParameters['orderby'] = maybeOrderByWiredName.value;
    }

    if (request.filterTag != null) {
      queryParameters['tag'] = Uri.encodeQueryComponent(request.filterTag);
    }

    final response = await cookieClient.dio.get<String>(
      '/$subjectTypeName/list/$username/$collectionStatusName',
      queryParameters: queryParameters,
    );

    if (!is2xxCode(response.statusCode)) {
      throw BangumiResponseIncomprehensibleException();
    }

    final message = ParseUserCollectionsListMessage(
      response.data,
      requestedPageNumber: webPageNumber,
      request: request,
      filterTag: request.filterTag,
    );

    return compute(processUserCollectionsList, message);
  }

  /// Gets count of unread notifications.
  Future<int> getUnreadNotificationsCount() async {
    final response = await cookieClient.dio.get('/json/notify');

    if (is2xxCode(response.statusCode)) {
      final decodedResponse = jsonDecode(response.data);

      if (decodedResponse is Map) {
        return tryParseInt(decodedResponse['count'], defaultValue: 0);
      }
    }

    throw BangumiResponseIncomprehensibleException();
  }

  /// List notifications items.
  ///
  /// [onlyUnread] is set to true by default, if set to true, all notification
  /// items as listed on bangumi will be returned.
  Future<BuiltList<BaseNotificationItem>> listNotifications({
    onlyUnread = true,
  }) async {
    String url;
    if (onlyUnread) {
      url = '/notify';
    } else {
      url = '/notify/all';
    }

    final response = await cookieClient.dio.get<String>(url);

    if (is2xxCode(response.statusCode)) {
      final message = ParseListNotificationMessage(response.data);

      return compute(processListNotification, message);
    }

    throw BangumiResponseIncomprehensibleException();
  }

  /// Clear an unread notification on bangumi.
  ///
  /// Either [notificationId] or [clearAll] must be presented.
  Future<void> clearUnreadNotifications({
    int notificationId,
    bool clearAll,
  }) async {
    assert(notificationId != null || clearAll != null);
    final xsrf = await cookieClient.getXsrfToken();

    final queryParameters = {
      'ajax': '1',
      'gh': xsrf,
    };

    String path;
    if (clearAll == true) {
      path = '/erase/notify/all';
    } else {
      path = '/erase/notify/$notificationId';
    }

    final response = await cookieClient.dio.get<String>(
      path,
      queryParameters: queryParameters,
      options: Options(
        contentType: ExtraContentType.xWwwFormUrlencoded,
      ),
    );

    final decodedResponse = jsonDecode(response.data);

    if (isBangumiWebPageOkResponse(decodedResponse)) {
      return;
    }

    throw BangumiResponseIncomprehensibleException();
  }

  Future<void> changeFriendRelationship({
    @required int userId,
    ChangeFriendRelationshipType actionType
  }) async {
    final xsrf = await cookieClient.getXsrfToken();

    final queryParameters = {
      'ajax': '1',
      'gh': xsrf,
    };

    String path;
    switch (actionType) {
      case ChangeFriendRelationshipType.Add:
        path = '/connect/$userId';
        break;
      case ChangeFriendRelationshipType.Remove:
      default:
        assert(actionType == ChangeFriendRelationshipType.Remove);
        throw UnimplementedError();
    }

    final response = await cookieClient.dio.get<String>(
      path,
      queryParameters: queryParameters,
      options: Options(
        contentType: ExtraContentType.xWwwFormUrlencoded,
      ),
    );

    final decodedResponse = jsonDecode(response.data);
    if (isBangumiWebPageOkResponse(decodedResponse)) {
      return;
    }

    throw BangumiResponseIncomprehensibleException();
  }
}
