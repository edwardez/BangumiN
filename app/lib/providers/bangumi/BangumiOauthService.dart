import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserIdentity.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/oauth/BangumiOauthClient.dart';
import 'package:munin/providers/bangumi/oauth/OauthHttpClient.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:oauth2/oauth2.dart'
    show AuthorizationCodeGrant, Client, Credentials;

// A client for Bangumi that authorizes user, send requests with oauth token and handles relevant persistence
class BangumiOauthService {
  BangumiCookieService _cookieClient;
  SecureStorageService secureStorageService;
  String authorizationUrl;
  BangumiOauthClient client;
  http.Client _baseOauthHttpClient;

  HttpServer _oauthServer;
  FlutterWebviewPlugin _flutterWebviewPlugin;

  BangumiOauthService({
    @required BangumiCookieService cookieClient,
    @required String serializedBangumiOauthCredentials,
    @required SecureStorageService secureStorageService,
    @required http.Client oauthHttpClient,
  }) {
    assert(secureStorageService != null);
    assert(cookieClient != null);
    assert(oauthHttpClient != null);

    this._cookieClient = cookieClient;
    this.secureStorageService = secureStorageService;
    this._baseOauthHttpClient = oauthHttpClient;

    if (serializedBangumiOauthCredentials != null) {
      Credentials credentials =
          Credentials.fromJson(serializedBangumiOauthCredentials);

      this.client = BangumiOauthClient(credentials,
          identifier: Application.environmentValue.bangumiOauthClientIdentifier,
          secret: Application.environmentValue.bangumiOauthClientSecret,
          basicAuth: false,
          httpClient: _baseOauthHttpClient,
          secureStorageService: secureStorageService);
    }
  }

  bool get hasOauthClient {
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

    // Creates a http client that retries 5 times for each request
    // This client is only used during oauth authorization, it's because bangumi
    // oauth has a pretty high error rate and this process is very important so
    // retrying every requests multiple times.
    var retryableAuthHttpClient = OauthHttpClient(http.Client(), retries: 5);

    AuthorizationCodeGrant grant = AuthorizationCodeGrant(
        Application.environmentValue.bangumiOauthClientIdentifier,
        Uri.parse(Application.bangumiOauthAuthorizationEndpoint),
        Uri.parse(Application.bangumiOauthTokenEndpoint),
        secret: Application.environmentValue.bangumiOauthClientSecret,
        httpClient: retryableAuthHttpClient);
    authorizationUrl = grant
        .getAuthorizationUrl(
            Uri.parse(Application.environmentValue.bangumiRedirectUrl))
        .toString();

    _flutterWebviewPlugin = FlutterWebviewPlugin();
    _flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged state) async {
      if (state.type == WebViewState.finishLoad &&
          Uri.parse(state.url).host ==
              Application.environmentValue.bangumiNonCdnHost) {
        Map<String, String> cookies = await _flutterWebviewPlugin.getCookies();

        // TODO: fix cookie parsing problem in flutter webview plugin(There must be something
        // wrong with this plugin...)
        // TODO: figure out why sometimes [chii_auth] is never in returned
        // cookies while user is actually logged-in
        String authCookie = cookies['chii_auth'] ??
            cookies[' chii_auth'] ??
            cookies['"chii_auth'] ??
            cookies['chii_auth"'];
        String sessionCookie = cookies['chii_sid'] ??
            cookies[' chii_sid'] ??
            cookies['"chii_sid'] ??
            cookies['chii_sid"'];

        if (authCookie != null && sessionCookie != null) {
          String userAgent =
              await _flutterWebviewPlugin.evalJavascript('navigator.userAgent');

          // On some devices, flutter webview plugin returns a trailing
          // dummy quotation mark.
          userAgent = userAgent.replaceAll(userAgentDummyStringRegex, '');

          String expiresOnInSecondsStr = cookies['chii_cookietime'] ??
              cookies[' chii_cookietime'] ??
              cookies['"chii_cookietime'] ??
              cookies['chii_cookietime"'];

          this._cookieClient.updateBangumiAuthInfo(
              authCookie: authCookie,
              sessionCookie: sessionCookie,
              userAgent: userAgent,
              expiresOnInSeconds:
                  tryParseInt(expiresOnInSecondsStr, defaultValue: null));
        }
      }
    });

    Stream<String> onCode = await _server();
    final String code = await onCode.first;

    // HACK: injects original oauth client and initializes a new customized
    // client
    Client baseOauthClient =
        await grant.handleAuthorizationResponse({'code': code});
    Credentials credentials =
        Credentials.fromJson(baseOauthClient.credentials.toJson());

    client = BangumiOauthClient(credentials,
        identifier: Application.environmentValue.bangumiOauthClientIdentifier,
        secret: Application.environmentValue.bangumiOauthClientSecret,
        basicAuth: false,
        httpClient: _baseOauthHttpClient,
        secureStorageService: secureStorageService);

    _flutterWebviewPlugin.close();
    _flutterWebviewPlugin.dispose();

    // At the end of authentication, `bangumiCookieCredential` must not be null.
    // In other words, `_flutterWebviewPlugin.onStateChanged.listen` must have
    // received a valid `bangumiCookieCredential`, if not, authentication has failed.
    if (!_cookieClient.hasCookieCredential) {
      throw AuthenticationFailedException('认证失败，请稍后重试');
    }
  }

  Future<Stream<String>> _server() async {
    final StreamController<String> onCode = new StreamController();
    _oauthServer = await HttpServer.bind(InternetAddress.loopbackIPv4, 28902);
    _oauthServer?.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType)
        ..write("<html lang='en'></html>");
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
    return this
        .secureStorageService
        .persistBangumiOauthCredentials(client.credentials);
  }

  Future<void> clearCredentials() async {
    return this.secureStorageService.clearBangumiOauthCredentials();
  }
}
