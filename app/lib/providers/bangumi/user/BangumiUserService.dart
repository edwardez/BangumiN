import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/user/parser/UserParser.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A Bangumi user service that handles user-related http requests and persist relevant info
class BangumiUserService {
  SharedPreferences sharedPreferences;
  BangumiOauthClient oauthClient;
  BangumiCookieClient cookieClient;

  BangumiUserService(
      {@required this.oauthClient,
      @required this.cookieClient,
      @required this.sharedPreferences})
      : assert(oauthClient != null),
        assert(cookieClient != null),
        assert(sharedPreferences != null);

  // persist current bangumi user basic info through api
  Future<BangumiUserBasic> persistCurrentUserBasicInfo(String username) async {
    BangumiUserBasic basicInfo = await getUserBasicInfo(username);
    await persistCurrentUserInfo(basicInfo);
    return basicInfo;
  }

  // get bangumi user basic info through api
  Future<BangumiUserBasic> getUserBasicInfo(String username) async {
    final response =
    await oauthClient.client.get('https://${Application.environmentValue
        .bangumiApiHost}/user/$username');

    BangumiUserBasic basicInfo =
        BangumiUserBasic.fromJson(response.body);
    return basicInfo;
  }

  // get bangumi user basic info through api
  Future<UserProfile> getUserPreview(String username) async {
    final response =
    await cookieClient.dio.get<String>('https://${Application.environmentValue
        .bangumiNonCdnHost}/user/$username');

    UserProfile profile = UserParser().process(response.data);
    return profile;
  }

  Future<bool> persistCurrentUserInfo(
      BangumiUserBasic currentAuthenticatedUserBasicInfo) {
    return sharedPreferences.setString('currentAuthenticatedUserBasicInfo',
        currentAuthenticatedUserBasicInfo.toJson());
  }
}
