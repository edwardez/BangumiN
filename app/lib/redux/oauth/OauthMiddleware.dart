import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:munin/providers/bangumi/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/BangumiUserService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createOauthMiddleware(
    BangumiOauthClient oauthClient,
    BangumiCookieClient cookieClient,
    BangumiUserService bangumiUserService,
    SharedPreferences preferences) {
  final loginPage = _createLoginPage();

  final oauthRequest =
      _createOAuthRequest(oauthClient, cookieClient, bangumiUserService);
  final oauthCancel = _createOAuthCancel(oauthClient, cookieClient);

  final logoutRequest =
      _createLogoutRequest(oauthClient, cookieClient, preferences);

  return [
    TypedMiddleware<AppState, LoginPage>(loginPage),
    TypedMiddleware<AppState, LogoutRequest>(logoutRequest),
    TypedMiddleware<AppState, OAuthLoginRequest>(oauthRequest),
    TypedMiddleware<AppState, OAuthLoginCancel>(oauthCancel),
  ];
}

Middleware<AppState> _createLoginPage() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action.context != null) {
      Navigator.of(action.context).pushNamed('/login');
    }

    next(action);
  };
}

// TODO: refactor this messy middleware
Middleware<AppState> _createOAuthRequest(
    BangumiOauthClient oauthClient,
    BangumiCookieClient bangumiCookieClient,
    BangumiUserService bangumiUserService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    assert(action.context != null);

    try {
      Navigator.of(action.context).pushNamed('/bangumiOauth');
      await oauthClient.initializeAuthentication();
      int userId = await oauthClient.verifyUser();
      BangumiUserBasic userInfo =
          await bangumiUserService.getUserBasicInfo(userId);
      await Future.wait([
        oauthClient.persistCredentials(),
        bangumiCookieClient.persistCredentials(),
        bangumiUserService.persistCurrentUserInfo(userInfo)
      ]);
      store.dispatch(OAuthLoginSuccess(userInfo));
      Navigator.of(action.context).pushReplacementNamed('/home');
    } catch (error, stack) {
      final maxErrorMessageMaxLength = 200;
      final errorMessage = error.toString();

      print(errorMessage);
      print(stack);
      Navigator.of(action.context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      store.dispatch(OAuthLoginFailure(
          action.context,
          error.toString().substring(
              0, min(errorMessage.length, maxErrorMessageMaxLength))));
    }

    next(action);
  };
}

Middleware<AppState> _createOAuthCancel(
    BangumiOauthClient oauthClient, BangumiCookieClient bangumiCookieClient) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    assert(action.context != null);
    await oauthClient.disposeServerAndWebview();
    next(action);
  };
}

Middleware<AppState> _createLogoutRequest(BangumiOauthClient oauthClient,
    BangumiCookieClient cookieClient, SharedPreferences preferences) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    assert(action.context != null);
    await Future.wait([
      oauthClient.clearCredentials(),
      cookieClient.clearCredentials(),
      preferences.clear()
    ]);
    store.dispatch(LogoutSuccess(action.context));
    Navigator.of(action.context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    next(action);
  };
}
