import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:munin/main.dart';
import 'package:munin/models/Bangumi/BangumiUserBaic.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/BangumiUserService.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/redux/app/AppReducer.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthMiddleware.dart';
import 'package:munin/redux/timeline/TimelineMiddleware.dart';
import 'package:munin/shared/injector/injector.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt();

enum EnvironmentType {
  Development,
  Uat,
  Production
}

abstract class Environment {
  static Environment value;

  final bangumiOauthAuthorizationEndpoint = 'https://bgm.tv/oauth/authorize';
  final bangumiOauthTokenEndpoint = 'https://bgm.tv/oauth/access_token';
  final bangumiMainHost = 'bgm.tv';

  EnvironmentType environmentType;
  String bangumiOauthClientIdentifier;
  String bangumiOauthClientSecret;
  String bangumiRedirectUrl;

  Environment() {
    initialize();
  }

  initialize() async {
    value = this;
    await injector(getIt);

    final BangumiCookieClient _bangumiCookieClient =
    getIt.get<BangumiCookieClient>();
    final BangumiOauthClient _bangumiOauthClient =
    getIt.get<BangumiOauthClient>();
    final BangumiUserService bangumiUserService =
    getIt.get<BangumiUserService>();
    final BangumiTimelineService _bangumiTimelineService =
    getIt.get<BangumiTimelineService>();
    final SharedPreferences preferences = getIt.get<SharedPreferences>();
    final String serializedUserInfo =
    preferences.get('currentAuthenticatedUserBasicInfo');

    bool _isAuthenticated =
        _bangumiCookieClient.readyToUse() && _bangumiOauthClient.readyToUse();

    BangumiUserBasic userInfo;
    if (serializedUserInfo != null) {
      try {
        userInfo = BangumiUserBasic.fromJson(serializedUserInfo);
      } catch (e) {
        // user profile might have corrupted, re-authentication is needed
        _isAuthenticated = false;
      }
    }

    final store = new Store<AppState>(appReducer, initialState: AppState((b) {
      if (userInfo != null) {
        b.currentAuthenticatedUserBasicInfo.replace(userInfo);
      }
      return b..isAuthenticated = _isAuthenticated;
    }),
        middleware: [
          //LoggingMiddleware.printer(),
        ]
          ..addAll(createOauthMiddleware(_bangumiOauthClient,
              _bangumiCookieClient, bangumiUserService, preferences))..addAll(
              createTimelineMiddleware(_bangumiTimelineService)));

    runApp(MuninApp(this, store));
  }

  String get name => runtimeType.toString();
}
