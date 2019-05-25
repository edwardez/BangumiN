import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:munin/main.dart';
import 'package:munin/models/bangumi/setting/theme/ThemeSwitchMode.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/discussion/BangumiDiscussionService.dart';
import 'package:munin/providers/bangumi/progress/BangumiProgressService.dart';
import 'package:munin/providers/bangumi/search/BangumiSearchService.dart';
import 'package:munin/providers/bangumi/subject/BangumiSubjectService.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/redux/app/AppEpics.dart';
import 'package:munin/redux/app/AppReducer.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionEpics.dart';
import 'package:munin/redux/oauth/OauthMiddleware.dart';
import 'package:munin/redux/progress/ProgressEpics.dart';
import 'package:munin/redux/search/SearchEpics.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/redux/setting/SettingEpics.dart';
import 'package:munin/redux/subject/SubjectEpics.dart';
import 'package:munin/redux/timeline/TimelineEpics.dart';
import 'package:munin/redux/user/UserEpics.dart';
import 'package:munin/shared/injector/injector.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ignore: unused_import

final GetIt getIt = GetIt();

enum EnvironmentType { Development, Uat, Production }

abstract class Application {
  static Application environmentValue;
  static Router router;

  static final String bangumiOauthAuthorizationEndpoint =
      'https://bgm.tv/oauth/authorize';
  static final String bangumiOauthTokenEndpoint =
      'https://bgm.tv/oauth/access_token';

  /// bgm.tv is the cdn version(behind cloud flare) of bangumi, it's the main host
  /// of bangumi(i.e. static assets under `lain.bgm.tv`, api under `api.bgm.tv`)
  final bangumiMainHost = 'bgm.tv';

  /// bangumi.tv is the non-cdn version of bangumi, it's mainly used for parsing html
  final bangumiNonCdnHost = 'bangumi.tv';
  final bangumiApiHost = 'api.bgm.tv';
  final forsetiApiHost = 'api.bangumin.tv';

  EnvironmentType environmentType;
  String bangumiOauthClientIdentifier;
  String bangumiOauthClientSecret;
  String bangumiRedirectUrl;

  Application() {
    _initialize();
  }

  _initialize() async {
    environmentValue = this;

    /// misc utils initialization
    TimeUtils.initializeTimeago();

    /// service locator initialization
    await injector(getIt);

    final BangumiCookieService bangumiCookieService =
    getIt.get<BangumiCookieService>();
    final BangumiOauthService bangumiOauthService =
    getIt.get<BangumiOauthService>();
    final BangumiUserService bangumiUserService =
    getIt.get<BangumiUserService>();
    final BangumiTimelineService bangumiTimelineService =
    getIt.get<BangumiTimelineService>();
    final BangumiSubjectService bangumiSubjectService =
    getIt.get<BangumiSubjectService>();
    final BangumiSearchService bangumiSearchService =
    getIt.get<BangumiSearchService>();
    final BangumiDiscussionService bangumiDiscussionService =
    getIt.get<BangumiDiscussionService>();
    final BangumiProgressService bangumiProgressService =
    getIt.get<BangumiProgressService>();
    final SharedPreferenceService sharedPreferenceService =
    getIt.get<SharedPreferenceService>();


    AppState appState = await _initializeAppState(
        bangumiCookieService, bangumiOauthService, sharedPreferenceService);
    bangumiOauthService?.client?.currentUser =
        appState?.currentAuthenticatedUserBasicInfo;

    /// redux initialization
    Epic<AppState> epics = combineEpics<AppState>([
      ...createAppEpics(sharedPreferenceService),
      ...createSubjectEpics(bangumiSubjectService),
      ...createSearchEpics(bangumiSearchService),
      ...createDiscussionEpics(bangumiDiscussionService),
      ...createTimelineEpics(bangumiTimelineService, bangumiUserService),
      ...createUserEpics(bangumiUserService),
      ...createProgressEpics(bangumiProgressService),
      ...createSettingEpics(bangumiUserService),
    ]);
    final store = Store<AppState>(appReducer, initialState: appState,
        middleware: [
//          LoggingMiddleware.printer(),
          EpicMiddleware<AppState>(epics),
        ]
          ..addAll(createOauthMiddleware(
              bangumiOauthService,
              bangumiCookieService,
              bangumiUserService,
              sharedPreferenceService)));

    if (store.state.settingState.themeSetting.themeSwitchMode ==
        ThemeSwitchMode.FollowScreenBrightness) {
      store.dispatch(UpdateThemeSettingAction(
          themeSetting: store.state.settingState.themeSetting));
    }

    _initializrCrashlytics();

    await _checkAuthenticationInfo(bangumiOauthService);

    /// flutter initialization
    runApp(MuninApp(this, store));
  }

  _initializrCrashlytics() {
    if (environmentType != EnvironmentType.Development) {
      FlutterError.onError = (FlutterErrorDetails details) {
        Crashlytics.instance.onError(details);
      };
    }
  }

  _checkAuthenticationInfo(BangumiOauthService bangumiOauthService) async {
    if (bangumiOauthService.client != null && bangumiOauthService.client
        .shouldRefreshAccessToken()) {
      await bangumiOauthService.client.refreshCredentials();
    }
  }

  Future<AppState> _initializeAppState(
      BangumiCookieService bangumiCookieService,
      BangumiOauthService bangumiOauthService,
      SharedPreferenceService sharedPreferenceService) async {
    bool isAuthenticated =
        bangumiCookieService.readyToUse() && bangumiOauthService.readyToUse();
    Optional<AppState> maybePersistedAppState =
    await sharedPreferenceService.readAppState();
    AppState persistedAppState;

    if (maybePersistedAppState.isPresent) {
      persistedAppState = maybePersistedAppState.value;
    } else {
      persistedAppState = AppState();
    }

    persistedAppState =
        persistedAppState.rebuild((b) => b..isAuthenticated = isAuthenticated);

    return persistedAppState;
  }

  String get name => runtimeType.toString();
}
