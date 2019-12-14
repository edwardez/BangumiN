import 'package:fluro/fluro.dart';
import 'package:munin/config/application.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/providers/storage/SharedPreferenceService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createOauthMiddleware(
    BangumiOauthService oauthClient,
    BangumiCookieService cookieClient,
    BangumiUserService bangumiUserService,
    SharedPreferenceService sharedPreferenceService) {
  final oauthRequest = _createUpdateLoginData(
      oauthClient, cookieClient, bangumiUserService, sharedPreferenceService);

  final logoutRequest =
      _createLogoutRequest(oauthClient, cookieClient, sharedPreferenceService);

  return [
    TypedMiddleware<AppState, LogoutRequest>(logoutRequest),
    TypedMiddleware<AppState, UpdateLoginDataAction>(oauthRequest),
  ];
}

Middleware<AppState> _createUpdateLoginData(
  BangumiOauthService oauthService,
  BangumiCookieService cookieService,
  BangumiUserService bangumiUserService,
  SharedPreferenceService sharedPreferenceService,
) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    assert(action.context != null);

    try {
      final userInfo = action.userInfo;
      oauthService.client.currentUser = userInfo;

      AppState updatedAppState = store.state.rebuild((b) => b
        ..isAuthenticated = true
        ..currentAuthenticatedUserBasicInfo.replace(userInfo));
      await Future.wait([
        oauthService.persistCredentials(),
        cookieService.persistCredentials(),
        sharedPreferenceService.persistBasicAppState(updatedAppState)
      ]);
      store.dispatch(OAuthLoginSuccess(userInfo));
      Application.router.navigateTo(action.context, Routes.homeRoute,
          transition: TransitionType.native, clearStack: true);
    } catch (error, stack) {
      reportError(error, stack: stack);
      Application.router.navigateTo(action.context, Routes.loginRoute,
          transition: TransitionType.native, clearStack: true);
    }

    next(action);
  };
}

Middleware<AppState> _createLogoutRequest(
    BangumiOauthService oauthClient,
    BangumiCookieService cookieService,
    SharedPreferenceService sharedPreferenceService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    assert(action.context != null);
    cookieService.silentlyTryLogout();
    await Future.wait([
      oauthClient.clearCredentials(),
      cookieService.clearCredentials(),
      sharedPreferenceService.deleteAppState(),
    ]);
    store.dispatch(LogoutSuccess(action.context));
    Application.router.navigateTo(action.context, Routes.loginRoute,
        transition: TransitionType.native, clearStack: true);
    next(action);
  };
}
