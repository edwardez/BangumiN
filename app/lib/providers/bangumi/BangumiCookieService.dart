import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/BangumiCookieCredentials.dart';
import 'package:munin/providers/storage/SecureStorageService.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:quiver/strings.dart';

// A client for Bangumi thst sends requests with cookie and handles relevant persistence
class BangumiCookieService {
  BangumiCookieCredentials _bangumiCookieCredential;

  SecureStorageService _secureStorageService;

  Dio dio;

  BangumiCookieService({
    @required BangumiCookieCredentials bangumiCookieCredential,
    @required SecureStorageService secureStorageService,
    @required Dio dio,
  }) {
    this._bangumiCookieCredential = bangumiCookieCredential;
    this._secureStorageService = secureStorageService;
    this.dio = dio;
  }

  bool get hasCookieCredential {
    return _bangumiCookieCredential != null;
  }

  /// Updates in-memory bangumi auth credentials info
  void updateBangumiAuthInfo(
      {String authCookie,
      String sessionCookie,
      String userAgent,
      int expiresOnInSeconds}) {
    assert(authCookie != null);
    assert(userAgent != null);
    assert(sessionCookie != null);

    // A small offset to ensure expiration check passes
    const int expirationOffsetInSeconds = 10;

    DateTime expiresOn;

    if (expiresOnInSeconds != null &&
        expiresOnInSeconds != 0 &&
        expiresOnInSeconds - expirationOffsetInSeconds > 0) {
      expiresOn = DateTime.now()
          .add(Duration(
              seconds: (expiresOnInSeconds - expirationOffsetInSeconds)))
          .toUtc();
    } else {
      // If bangumi returns 0 or null for expiresOnInSeconds(=chii_cookietime)
      // Most likely user has selected a session life-length cookie time
      // There is no good way to know actual expiration time in this case
      // But bangumi always assign a cookie that expires in 30 days, assigning
      // a cookie that expires after 29 days should be fine for NOW.
      expiresOn = DateTime.now().add(Duration(days: 29)).toUtc();
    }

    // Writes to keystore/keychain
    _bangumiCookieCredential = BangumiCookieCredentials((b) => {
          b
            ..authCookie = authCookie
            ..sessionCookie = sessionCookie
            ..userAgent = userAgent
            ..expiresOn = expiresOn
        });

    updateDioHeaders(
        authCookie: authCookie,
        sessionCookie: sessionCookie,
        userAgent: userAgent);
  }

  void updateDioHeaders(
      {String authCookie, String sessionCookie, String userAgent}) {
    List<Cookie> cookies = [
      Cookie("chii_auth", authCookie),
      Cookie("chii_sid", sessionCookie)
    ];

    var cookieJar = getIt.get<CookieJar>();

    /// Save authenticated cookie for both version of bangumi
    cookieJar.saveFromResponse(Uri.parse("https://$bangumiMainHost"), cookies);
    cookieJar.saveFromResponse(
        Uri.parse("https://$bangumiNonCdnHost"), cookies);
    dio.options.headers[HttpHeaders.userAgentHeader] = userAgent;
  }

  Future<void> clearCredentials() {
    _bangumiCookieCredential = null;
    return _secureStorageService.clearBangumiCookieCredentials();
  }

  Future<void> persistCredentials() {
    return _secureStorageService
        .persistBangumiCookieCredentials(_bangumiCookieCredential);
  }

  Future<String> getXsrfToken() async {
    /// TODO: find a better place where xsrf token is stored
    Response response = await dio.get('/settings/password');
    if (response.statusCode == 200) {
      DocumentFragment document = parseFragment(response.data);
      Element tokenElement = document.querySelector('input[name=formhash]');
      if (tokenElement != null &&
          isNotEmpty(tokenElement.attributes['value'])) {
        return tokenElement.attributes['value'];
      }
    }

    throw BangumiResponseIncomprehensibleException();
  }

  /// Tries to logout by sending a get request to web `https://bangumi.tv/logout`
  /// end point.
  /// Due to its fragile and unreliable nature(mocking a webpage request), there
  /// is no guarantee this action will succeed.
  Future<void> logout() async {
    var xsrfToken = await getXsrfToken();
    await dio.get('/logout/$xsrfToken');
  }

  /// Silently tries to logout without reporting any errors to upstream
  Future<void> silentlyTryLogout(
      {timeoutThreshold: const Duration(seconds: 3)}) async {
    try {
      await Future.any([
        logout(),
        Future.delayed(timeoutThreshold),
      ]);
    } catch (error, stack) {
      print(error);
      print(stack);
    }
  }
}
