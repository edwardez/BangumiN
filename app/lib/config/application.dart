import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:munin/main.dart';
import 'package:munin/models/bangumi/setting/privacy/PrivacySetting.dart';
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
import 'package:munin/providers/util/RetryableHttpClient.dart';
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
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/injector/injector.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:upgrader/upgrader.dart'; // ignore: unused_import

final GetIt getIt = GetIt();

enum EnvironmentType { Development, Uat, Production }

/// bgm.tv is the cdn version(behind cloud flare) of bangumi, it's the main host
/// of bangumi(i.e. static assets under `lain.bgm.tv`, api under `api.bgm.tv`)
const bangumiMainHost = 'bgm.tv';
/// bangumi.tv is the non-cdn version of bangumi, it's mainly used for parsing html
const bangumiNonCdnHost = 'bangumi.tv';
const upgradeInfoUrl = 'https://raw.githubusercontent.com/edwardez/BangumiN/tree/master/app/lib/config/upgrader/production_appcast.xml';

abstract class Application {
  static Application environmentValue;
  static Router router;

  static final String bangumiOauthAuthorizationEndpoint =
      'https://bgm.tv/oauth/authorize';
  static final String bangumiOauthTokenEndpoint =
      'https://bgm.tv/oauth/access_token';

  final bangumiApiHost = 'api.bgm.tv';
  final forsetiMainHost = 'bangumin.tv';
  final forsetiApiHost = 'api.bangumin.tv';

  /// Bangumi host that dio will be using.
  /// This is required because some bangumi hosts are blocked by cloudflare
  /// see https://github.com/edwardez/BangumiN/commit/f901f1cde4b9a80f04b6195a1502f07f0c059e9a
  String _bangumiHostForDio = bangumiNonCdnHost;

  String get bangumiHostForDio => _bangumiHostForDio;

  EnvironmentType environmentType;
  String bangumiOauthClientIdentifier;
  String bangumiOauthClientSecret;
  String bangumiRedirectUrl;

  /// Whether the app should activate the update detector to check new version
  /// Currently, only app that's installed by a local .apk should enable this
  /// option.
  bool shouldCheckUpdate = false;

  Application() {
    _initialize();
  }

  _initialize() async {
    environmentValue = this;

    assert(!shouldCheckUpdate ||
        (shouldCheckUpdate && Platform.isAndroid));

    // misc utils initialization
    TimeUtils.initializeTimeago();

    _bangumiHostForDio = await _decideBangumiHostForDio();

    // service locator initialization
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
        appState.currentAuthenticatedUserBasicInfo;

    _initializeTelemetry(appState.settingState.privacySetting);

    // redux initialization
    Epic<AppState> epics = combineEpics<AppState>([
      ...createAppEpics(sharedPreferenceService),
      ...createSubjectEpics(
        bangumiSubjectService,
        bangumiProgressService,
      ),
      ...createSearchEpics(bangumiSearchService),
      ...createDiscussionEpics(bangumiDiscussionService),
      ...createTimelineEpics(bangumiTimelineService, bangumiUserService),
      ...createUserEpics(bangumiUserService),
      ...createProgressEpics(bangumiProgressService),
      ...createSettingEpics(bangumiUserService, bangumiCookieService),
    ]);
    final store = Store<AppState>(appReducer,
        initialState: appState,
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

    await _checkAuthenticationInfo(bangumiOauthService);

    // flutter initialization
    runApp(MuninApp(this, store));
  }

  /// Initializes analytics and crashlytics.
  _initializeTelemetry(PrivacySetting privacySetting) {
    if (environmentType != EnvironmentType.Development &&
        privacySetting.optInAutoSendCrashReport) {
      FlutterError.onError = (FlutterErrorDetails details) {
        Crashlytics.instance.onError(details);
      };
    }

    // If user has chosen to opt out analytics, disable it here.
    // This setting is persisted through app session so we just need to set it
    // once on app startup.
    FirebaseAnalytics()
        .setAnalyticsCollectionEnabled(privacySetting.optInAnalytics);
  }

  _checkAuthenticationInfo(BangumiOauthService bangumiOauthService) async {
    // Silently ignores any error: failing to refresh credentials shouldn't
    // prevent user from accessing the app.
    try {
      if (bangumiOauthService.client != null &&
          bangumiOauthService.client.shouldRefreshAccessToken()) {
        await bangumiOauthService.client.refreshCredentials();
      }
    } catch (exception, stack) {
      reportError(exception, stack: stack);
    }
  }

  Future<AppState> _initializeAppState(
      BangumiCookieService bangumiCookieService,
      BangumiOauthService bangumiOauthService,
      SharedPreferenceService sharedPreferenceService) async {
    AppState persistedAppState;

    try {
      Optional<AppState> maybePersistedAppState =
      await sharedPreferenceService.readAppState();

      if (maybePersistedAppState.isPresent &&
          maybePersistedAppState.value.currentAuthenticatedUserBasicInfo !=
              null) {
        persistedAppState = maybePersistedAppState.value;
      } else {
        // If [maybePersistedAppState] is absent while credentials are presented.
        // Or user info is null.
        // It indicates user has uninstalled the app but credentials are not
        // cleared, hence clearing the credentials.
        bangumiCookieService.clearCredentials();
        bangumiOauthService.clearCredentials();

        persistedAppState = AppState();
        return persistedAppState;
      }
    } catch (error, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        stack: stack,
      ));
      bangumiCookieService.clearCredentials();
      bangumiOauthService.clearCredentials();
      persistedAppState = AppState();
    }

    bool isAuthenticated = bangumiCookieService.hasCookieCredential &&
        bangumiOauthService.hasOauthClient;
    persistedAppState =
        persistedAppState.rebuild((b) => b..isAuthenticated = isAuthenticated);

    return persistedAppState;
  }

  /// Decide which host dio should use by checking bgm.tv and bangumi.tv
  /// with a preference for bangumi.tv
  /// This might force user to log out if user login with bangumi.tv
  /// then [_decideBangumiHostForDio] returns bgm.tv and cookies are not shared
  /// across domains.
  /// However seems like bangumi share cookies across these two domains now.
  /// TODO: maybe make this method reactive to network change?
  Future<String> _decideBangumiHostForDio() async {
    // iOS app store requires app to be functional in pure ipv6 environment.
    // While [bangumiNonCdnHost] doesn't support. If the target platform is not iOS,
    // there is no need to continue.
    if (!Platform.isIOS) {
      return bangumiNonCdnHost;
    }
    final retryableClient = RetryableHttpClient(
      http.Client(),
      retries: 3,
      whenError: ((_, __) => true),
      delay: (_) => Duration(),
    );
    try {
      await retryableClient.get('https://$bangumiNonCdnHost/json/notify');
      return bangumiNonCdnHost;
    } catch (error, stack) {
      reportError(error, stack: stack);
    }

    try {
      await retryableClient.get('https://$bangumiMainHost/json/notify');
      return bangumiMainHost;
    } catch (error, stack) {
      reportError(error, stack: stack);
    }

    // [bangumiMainHost] supports ipv6, if the connectivity issue is due to
    // ipv6, above code should work. However if it's due to something else
    // (i.e. user is not connected to a network). Then [bangumiNonCdnHost]
    // will still be used.
    return bangumiNonCdnHost;
  }

  String get name => runtimeType.toString();
}
