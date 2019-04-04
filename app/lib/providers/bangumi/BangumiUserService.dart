import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
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

  // get bangumi user basic info through api
  Future<BangumiUserBasic> getUserBasicInfo(int id) async {
    final response =
    await oauthClient.client.get('https://api.bgm.tv/user/$id');

    BangumiUserBasic currentAuthenticatedUserBasicInfo =
        BangumiUserBasic.fromJson(response.body);
    await persistCurrentUserInfo(currentAuthenticatedUserBasicInfo);
    return currentAuthenticatedUserBasicInfo;
  }

  Future<bool> persistCurrentUserInfo(
      BangumiUserBasic currentAuthenticatedUserBasicInfo) {
    return sharedPreferences.setString('currentAuthenticatedUserBasicInfo',
        currentAuthenticatedUserBasicInfo.toJson());
  }
}
