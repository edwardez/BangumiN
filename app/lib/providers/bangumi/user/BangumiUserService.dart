import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/user/parser/ImportBlockedUserParser.dart';
import 'package:munin/providers/bangumi/user/parser/UserCollectionsListParser.dart';
import 'package:munin/providers/bangumi/user/parser/isolate.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/http/common.dart';

// A Bangumi user service that handles user-related http requests and persist relevant info
class BangumiUserService {
  SharedPreferenceService sharedPreferenceService;
  BangumiOauthService oauthClient;
  BangumiCookieService cookieClient;

  BangumiUserService(
      {@required this.oauthClient,
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
        'https://${Application.environmentValue.bangumiApiHost}/user/$username');

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

  Future<ParsedCollections> listUserCollections(
      {@required ListUserCollectionsRequest request,
      @required int requestedPageNumber}) async {
    final username = request.username;
    final subjectTypeName = request.subjectType.name.toLowerCase();
    final collectionStatusName = request.collectionStatus.wiredName;

    Map<String, String> queryParameters = {};
    if (requestedPageNumber >= 2) {
      queryParameters['page'] = requestedPageNumber.toString();
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
      requestedPageNumber: requestedPageNumber,
      request: request,
    );

    return compute(processUserCollectionsList, message);
  }
}
