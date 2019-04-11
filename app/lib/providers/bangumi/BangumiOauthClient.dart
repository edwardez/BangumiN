import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserIdentity.dart';
import 'package:munin/providers/bangumi/BangumiCookieClient.dart';
import 'package:oauth2/oauth2.dart' show Client, AuthorizationCodeGrant;
import 'package:oauth2/oauth2.dart' as oauth2;

// A client for Bangumi that authorizes user, send requests with oauth token and handles relevant persistence
class BangumiOauthClient {
  BangumiCookieClient _cookieClient;
  FlutterSecureStorage secureStorage;
  String authorizationUrl;
  Client client;

  HttpServer _oauthServer;
  FlutterWebviewPlugin _flutterWebviewPlugin;

  BangumiOauthClient(
      {@required BangumiCookieClient cookieClient,
      @required String serializedBangumiOauthCredentials,
      @required FlutterSecureStorage secureStorage}) {
    assert(secureStorage != null);
    assert(cookieClient != null);

    this._cookieClient = cookieClient;
    this.secureStorage = secureStorage;

    if (serializedBangumiOauthCredentials != null) {
      oauth2.Credentials credentials =
          oauth2.Credentials.fromJson(serializedBangumiOauthCredentials);
      this.client = oauth2.Client(credentials,
          identifier: Application.environmentValue.bangumiOauthClientIdentifier,
          secret: Application.environmentValue.bangumiOauthClientSecret,
          basicAuth: false
      );
    }
  }

  BangumiOauthClient.fromCredentials(
      {@required BangumiCookieClient cookieClient,
      @required String serializedBangumiOauthCredentials,
      @required secureStorage}) {
    assert(secureStorage != null);
    assert(cookieClient != null);

    this._cookieClient = cookieClient;
    this.secureStorage = secureStorage;
    oauth2.Credentials credentials =
        oauth2.Credentials.fromJson(serializedBangumiOauthCredentials);
    this.client = oauth2.Client(credentials,
        identifier: Application.environmentValue.bangumiOauthClientIdentifier,
        secret: Application.environmentValue.bangumiOauthClientSecret,
        basicAuth: false
    );
  }

  /// calling this constructor will not produce a read-to-use client, it prepares
  /// values that are needed to initialize a new client
  BangumiOauthClient.setUpForAuthorization(
      {@required BangumiCookieClient cookieClient, @required secureStorage}) {
    assert(secureStorage != null);
    assert(cookieClient != null);

    this._cookieClient = cookieClient;
    this.secureStorage = secureStorage;
  }

  bool readyToUse() {
    return client != null;
  }

  String getAuthorizationUrl() {
    return authorizationUrl;
  }

  Future<int> verifyUser() async {
    Response tokenStatus = await http.post('https://bgm.tv/oauth/token_status',
        body: {'access_token': client.credentials.accessToken});
    return BangumiUserIdentity.fromJson(tokenStatus.body).id;
  }

  Future<void> initializeAuthentication() async {
    assert(_cookieClient != null);

    AuthorizationCodeGrant grant = new AuthorizationCodeGrant(
        Application.environmentValue.bangumiOauthClientIdentifier,
        Uri.parse(
            Application.environmentValue.bangumiOauthAuthorizationEndpoint),
        Uri.parse(Application.environmentValue.bangumiOauthTokenEndpoint),
        secret: Application.environmentValue.bangumiOauthClientSecret);
    authorizationUrl = grant
        .getAuthorizationUrl(
        Uri.parse(Application.environmentValue.bangumiRedirectUrl))
        .toString();

    _flutterWebviewPlugin = FlutterWebviewPlugin();
    _flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged state) async {
      if (state.type == WebViewState.finishLoad &&
          Uri.parse(state.url).host == 'bgm.tv') {
        Map<String, String> cookies = await _flutterWebviewPlugin.getCookies();

        /// TODO: fix cookie parsing problem in flutter webview plugin
        /// TODO: figure out why sometimes [chii_auth] is never present in returned
        /// cookie while user is actually logged-in
        String authCookie = cookies['chii_auth'] ?? cookies[' chii_auth'];
        if (authCookie != null) {
          String userAgent =
              await _flutterWebviewPlugin.evalJavascript('navigator.userAgent');

          this._cookieClient.updateBangumiAuthInfo(
              authCookie: authCookie, userAgent: userAgent);
        }
      }
    });

    Stream<String> onCode = await _server();
    final String code = await onCode.first;
    client = await grant.handleAuthorizationResponse({'code': code});
    await persistCredentials();
    await _cookieClient.persistCredentials();
    _flutterWebviewPlugin.close();
    _flutterWebviewPlugin.dispose();
  }

  Future<Stream<String>> _server() async {
    final StreamController<String> onCode = new StreamController();
    _oauthServer = await HttpServer.bind(InternetAddress.loopbackIPv4, 28902);
    _oauthServer?.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType)
        ..write("<html></html>");
      await request.response.close();
      await _oauthServer?.close(force: true);
      onCode.add(code);
      await onCode.close();
    });
    return onCode.stream;
  }

  // dispose webview and server, if there is any
  Future<bool> disposeServerAndWebview() async {
    try {
      await _oauthServer?.close(force: true);
      await _flutterWebviewPlugin?.close();
      _flutterWebviewPlugin?.dispose();
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }

  Future<void> persistCredentials() {
    return this.secureStorage.write(
        key: 'bangumiOauthCredentials', value: client.credentials.toJson());
  }

  Future<void> clearCredentials() async {
    return this.secureStorage.delete(key: 'bangumiOauthCredentials');
  }
}
