import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/user/parser/ImportBlockedUserParser.dart';
import 'package:munin/providers/bangumi/user/parser/UserParser.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';

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
    final response =
    await oauthClient.client.get('https://${Application.environmentValue
        .bangumiApiHost}/user/$username');

    BangumiUserSmall basicInfo =
    BangumiUserSmall.fromJson(response.body);
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

  // Imports blocked users
  Future<BuiltMap<String, MutedUser>> importBlockedUser() async {
    final response =
    await cookieClient.dio.get<String>('https://${Application.environmentValue
        .bangumiNonCdnHost}/settings/privacy');

    BuiltMap<String, MutedUser> users = ImportBlockedUserParser().process(
        response.data);
    return users;
  }
}
