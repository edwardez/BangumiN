import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiUserIdentity.dart';
import 'package:munin/providers/bangumi/BangumiCookieService.dart';
import 'package:munin/providers/bangumi/oauth/BangumiOauthClient.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:munin/providers/util/RetryableHttpClient.dart';
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

  Future<void> processAuthentication({
    @required String oauthCode,
    @required String authCookie,
    @required String sessionCookie,
    @required String userAgent,
    @required String expiresOnInSecondsStr,
  }) async {
    this._cookieClient.updateBangumiAuthInfo(
        authCookie: authCookie,
        sessionCookie: sessionCookie,
        userAgent: userAgent,
        expiresOnInSeconds:
        tryParseInt(expiresOnInSecondsStr, defaultValue: null));

    var retryableAuthHttpClient = RetryableHttpClient(
        http.Client(), retries: 5);
    AuthorizationCodeGrant grant = AuthorizationCodeGrant(
        Application.environmentValue.bangumiOauthClientIdentifier,
        Uri.parse(Application.bangumiOauthAuthorizationEndpoint),
        Uri.parse(Application.bangumiOauthTokenEndpoint),
        secret: Application.environmentValue.bangumiOauthClientSecret,
        httpClient: retryableAuthHttpClient);
    // Ignore the generated url here since we're not using the normal way
    // to authorize user, but [AuthorizationCodeGrant] requires
    // [getAuthorizationUrl.getAuthorizationUrl] to be called once.
    grant
        .getAuthorizationUrl(
            Uri.parse(Application.environmentValue.bangumiRedirectUrl))
        .toString();

    // HACK: injects original oauth client and initializes a new customized
    // client
    Client baseOauthClient =
    await grant.handleAuthorizationResponse({'code': oauthCode});
    Credentials credentials =
        Credentials.fromJson(baseOauthClient.credentials.toJson());

    client = BangumiOauthClient(credentials,
        identifier: Application.environmentValue.bangumiOauthClientIdentifier,
        secret: Application.environmentValue.bangumiOauthClientSecret,
        basicAuth: false,
        httpClient: _baseOauthHttpClient,
        secureStorageService: secureStorageService);

    // At the end of authentication, `bangumiCookieCredential` must not be null.
    // In other words, `_flutterWebviewPlugin.onStateChanged.listen` must have
    // received a valid `bangumiCookieCredential`, if not, authentication has failed.
    if (!_cookieClient.hasCookieCredential) {
      throw AuthenticationFailedException('认证失败，请稍后重试');
    }
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
